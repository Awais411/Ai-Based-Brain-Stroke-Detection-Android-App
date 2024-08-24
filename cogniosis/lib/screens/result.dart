import 'dart:io';

import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../custom_bottom_navigation_bar.dart';
import '../utils/basic_screen_imports.dart';
import '../utils/detector_services.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_menu.dart';

class Result extends StatefulWidget {
  Result({super.key, this.image});
  XFile? image;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isLoading = true;
  Detector? _detector;
  Map? recognitions = {};
  XFile? pickedImage;

  Future<void> _initDetector() async {
    _detector = await Detector.start();
    await Future.delayed(const Duration(seconds: 1));
    _detector!.resultsStream.stream.listen((result) {
      setState(() {
        recognitions = result;
        isLoading = false;
      });
    });
  }

  Future<void> _detect() async {
    await Future.delayed(const Duration(seconds: 1), () {
      _detector!.processFrame(widget.image!);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDetector();
    _detect();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.bluebg,
      drawer: SizedBox(width: 250.w, child: CustomDrawer()),
      appBar: CustomAppBar(
        onMenuPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationPressed: () {},
        showBorder: true,
        scaffoldContext: context,
      ),
      body: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: CustomColor.uploadReporsScreen),
                          )),
                      SizedBox(
                        height: Dimensions.heightSizelarge,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 213.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                                color: CustomColor.uploadReporsScreen,
                                width: 5),
                          ),
                          child: Image.file(
                            File(widget.image!.path),
                            // height: 200.h,
                            fit: BoxFit.cover,

                            // fit: BoxFit.fitWidth,
                          )),
                      SizedBox(
                        height: Dimensions.heightSizelarge,
                      ),
                      buildResultContainer(),
                    ])),
    );
  }

  Widget buildResultContainer() {
    return Column(
      children: [
        InnerShadow(
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 1), // right and up
              blurRadius: 12.0,
            ),
          ],
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: CustomColor.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
              border: Border.all(
                  color: CustomColor.uploadReporsScreen), // Blue border
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Results',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CustomColor.uploadReporsScreen,
                        decoration: TextDecoration.underline,
                        decorationColor: CustomColor.uploadReporsScreen,
                        fontWeight: FontWeight.normal)),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Text('Disease:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: CustomColor.uploadReporsScreen,
                            )),
                    Text(
                      recognitions!['recognitions'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: recognitions!['recognitions'] == 'Normal'
                                ? Colors.green
                                : Colors.red,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    const Text(
                      'Accuracy:',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: CustomColor.uploadReporsScreen),
                    ),
                    RichText(
                      text: TextSpan(
                        text: recognitions!['score'],
                        style: const TextStyle(
                            color: CustomColor.blackColor), // Green color
                        children: const [
                          TextSpan(
                            text: '%',
                            style: TextStyle(
                                color: CustomColor.uploadReporsScreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'Note',
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'The result is generated by AI model. Consult with the doctor for further evaluations.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: CustomColor.uploadReporsScreen,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Get.offAll(const CustomBottomNavigationBar(index: 1));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.uploadReporsScreen,
                foregroundColor: CustomColor.whiteColor,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeVerticalSize,
                    vertical: 0)),
            child: const Text('Test Again')),
      ],
    );
  }
}
