import 'dart:async';
import 'dart:io';
import 'dart:isolate';
// import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image_lib;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

enum _Codes {
  init,
  busy,
  ready,
  detect,
  result,
}

class _Command {
  const _Command(this.code, {this.args});

  final _Codes code;
  final List<Object>? args;
}

class Detector {
  static const String _modelPath = 'assets/model/model.tflite';
  static const String _labelPath = 'assets/model/labels.txt';

  Detector._(this._isolate, this._interpreter, this._labels);

  final Isolate _isolate;
  late final Interpreter _interpreter;
  late final List<String> _labels;

  late final SendPort _sendPort;

  bool _isReady = false;

  final StreamController<Map<String, dynamic>> resultsStream =
      StreamController<Map<String, dynamic>>();

  static Future<Detector> start() async {
    final ReceivePort receivePort = ReceivePort();

    final Isolate isolate =
        await Isolate.spawn(_DetectorServer._run, receivePort.sendPort);

    final Detector result = Detector._(
      isolate,
      await _loadModel(),
      await _loadLabels(),
    );
    receivePort.listen((message) {
      result._handleCommand(message as _Command);
    });
    return result;
  }

  static Future<Interpreter> _loadModel() async {
    final interpreterOptions = InterpreterOptions();

    if (Platform.isAndroid) {
      interpreterOptions.addDelegate(XNNPackDelegate());
    }

    return Interpreter.fromAsset(
      _modelPath,
      options: interpreterOptions..threads = 4,
    );
  }

  static Future<List<String>> _loadLabels() async {
    return (await rootBundle.loadString(_labelPath)).split('\n');
  }

  void processFrame(XFile cameraImage) {
    if (_isReady) {
      _sendPort.send(_Command(_Codes.detect, args: [cameraImage]));
    }
  }

  void _handleCommand(_Command command) {
    switch (command.code) {
      case _Codes.init:
        _sendPort = command.args?[0] as SendPort;

        RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
        _sendPort.send(_Command(_Codes.init, args: [
          rootIsolateToken,
          _interpreter.address,
          _labels,
        ]));
      case _Codes.ready:
        _isReady = true;
      case _Codes.busy:
        _isReady = false;
      case _Codes.result:
        _isReady = true;
        resultsStream.add(command.args?[0] as Map<String, dynamic>);
      default:
        debugPrint('Detector unrecognized command: ${command.code}');
    }
  }

  void stop() {
    _isolate.kill();
  }
}

class _DetectorServer {
  static const int mlModelInputSize = 224;

  //static const double confidence = 0.8;
  Interpreter? _interpreter;
  List<String>? _labels;

  _DetectorServer(this._sendPort);

  final SendPort _sendPort;

  static void _run(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    final _DetectorServer server = _DetectorServer(sendPort);
    receivePort.listen((message) async {
      final _Command command = message as _Command;
      await server._handleCommand(command);
    });

    sendPort.send(_Command(_Codes.init, args: [receivePort.sendPort]));
  }

  Future<void> _handleCommand(_Command command) async {
    switch (command.code) {
      case _Codes.init:
        RootIsolateToken rootIsolateToken =
            command.args?[0] as RootIsolateToken;

        BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
        _interpreter = Interpreter.fromAddress(command.args?[1] as int);
        _labels = command.args?[2] as List<String>;
        _sendPort.send(const _Command(_Codes.ready));
      case _Codes.detect:
        _sendPort.send(const _Command(_Codes.busy));
        _convertCameraImage(command.args?[0] as XFile);
      default:
        debugPrint('_DetectorService unrecognized command ${command.code}');
    }
  }

  void _convertCameraImage(XFile cameraImage) {
    var preConversionTime = DateTime.now().millisecondsSinceEpoch;

    final path = cameraImage.path;
    final bytes = File(path).readAsBytesSync();
    final image = image_lib.decodeImage(bytes);
    final imageWidth = image!.width;
    final imageHeigth = image.height;
    final croppedImage = image_lib.copyCrop(image,
        x: 0,
        y: ((imageHeigth / 2) - (imageWidth / 2)).toInt(),
        width: imageWidth,
        height: imageWidth);

    final results = analyseImage(croppedImage, preConversionTime);
    _sendPort.send(_Command(_Codes.result, args: [results]));

    // convertCameraImageToImage(cameraImage).then((image) {
    //   if (image != null) {
    //     if (Platform.isAndroid) {
    //       image = image_lib.copyRotate(image, angle: 90);
    //     }

    //   }
    // });
  }

  Map<String, dynamic> analyseImage(
      image_lib.Image? image, int preConversionTime) {
    var conversionElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preConversionTime;

    var preProcessStart = DateTime.now().millisecondsSinceEpoch;
    final imageInput = image_lib.copyResize(
      image!,
      width: mlModelInputSize,
      height: mlModelInputSize,
    );

    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(
        imageInput.width,
        (x) {
          final pixel = imageInput.getPixel(x, y);
          //final average = ((pixel.r + pixel.g + pixel.b) / 3) - 127.5 / 255;
          return [pixel.r, pixel.g, pixel.g];
          //return [average];
        },
      ),
    );

    //   final imageMatrix = List.generate(
    //   imageInput.height,
    //   (y) => List.generate(
    //     imageInput.width,
    //     (x) {
    //       final pixel = imageInput.getPixel(x, y);
    //       final average = ((pixel.r + pixel.g + pixel.b) / 3) - 127.5 / 255;
    //       // return [image_lib.getLuminanceNormalized(pixel)];
    //       return [average];
    //     },
    //   ),
    // );

    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    final output = _runInference(imageMatrix);

    final result = output.first.first as List<double>;
    print(result);
    int index = 0;
    double score = 0.0;
    for (var i = 0; i < result.length; i++) {
      if (result[i] > score) {
        score = result[i];
        index = i;
      }
    }

    var inferenceElapsedTime =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    var totalElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preConversionTime;

    return {
      "recognitions": _labels![index],
      "score": (score * 100).toStringAsFixed(2),
      "stats": <String, String>{
        'Conversion time:': conversionElapsedTime.toString(),
        'Pre-processing time:': preProcessElapsedTime.toString(),
        'Inference time:': inferenceElapsedTime.toString(),
        'Total prediction time:': totalElapsedTime.toString(),
        'Frame': '${image.width} X ${image.height}',
      },
    };
  }

  // Float32List _imageToByteListFloat32(
  //     image_lib.Image image, int inputSize, double mean, double std) {
  //   var convertedBytes = Float32List(inputSize * inputSize);
  //   var buffer = Float32List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = image_lib.getLuminance(pixel) / 255.0;
  //     }
  //   }
  //   return convertedBytes.buffer.asFloat32List();
  // }

  List<List<Object>> _runInference(
    List<List<List<num>>> imageMatrix,
  ) {
    final input = [imageMatrix];
    print(input.shape);

    final output = {
      0: [List<num>.filled(2, 0.0)],
      // 1: [List<num>.filled(25, 0)],
      // 2: [List<num>.filled(25, 0)],
      // 3: [0.0],
    };

    _interpreter!.runForMultipleInputs([input], output);

    return output.values.toList();
  }
}
