import 'dart:io';
import 'package:image/image.dart' as img;

Future<bool> isXrayImage(String imagePath) async {
  // Load the image from the given path
  final imageFile = File(imagePath);
  final imageBytes = await imageFile.readAsBytes();
  final image = img.decodeImage(imageBytes);

  if (image == null) {
    throw Exception('Unable to decode image');
  }

  // Get the total number of pixels
  final totalPixels = image.width * image.height;
  int blackPixels = 0;

  // Define what we consider "black" - typically a pixel with RGB values (0, 0, 0)
  const int blackThreshold =
      50; // Define a threshold to consider a pixel as black

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r;
      final g = pixel.g;
      final b = pixel.b;

      // Check if the pixel is black
      if (r < blackThreshold && g < blackThreshold && b < blackThreshold) {
        blackPixels++;
      }
    }
  }

  // Calculate the percentage of black pixels
  final blackPixelPercentage = (blackPixels / totalPixels) * 100;

  // Check if more than 30% of the pixels are black
  print(blackPixelPercentage);
  return blackPixelPercentage > 20;
}
