import 'dart:io';

import 'package:cogniosis/screens/result.dart';
import 'package:cogniosis/utils/image_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/basic_screen_imports.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_menu.dart';

class UploadReport extends StatefulWidget {
  const UploadReport({super.key});

  @override
  State<UploadReport> createState() => _UploadReportState();
}

class _UploadReportState extends State<UploadReport> {
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
          child: _image == null
              ? Column(
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
                      SizedBox(height: Dimensions.heightSizelarge),
                      Text(
                        'File Upload',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: CustomColor.uploadReporsScreen,
                                fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: Dimensions.heightSizelarge),
                      buildUploadContainer(),
                      SizedBox(height: Dimensions.heightSizelarge),
                    ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 313.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(
                                  color: CustomColor.uploadReporsScreen,
                                  width: 5),
                            ),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSizelarge),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Result(
                                      image: pickedFile,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal:
                                Dimensions.paddingSizeHorizontalSize * 2),
                        backgroundColor: CustomColor.uploadReporsScreen,
                      ),
                      child: const Text('Get Results'),
                    )
                  ],
                )),
    );
  }

  Widget buildUploadContainer() {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(Dimensions.radiusMedium),
        dashPattern: const [8, 4],
        color: Colors.black,
        strokeWidth: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(32),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload,
                color: CustomColor.uploadReporsScreen,
                size: 100.r,
              ),
              SizedBox(height: 16.h),
              Text(
                'Select Files',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CustomColor.uploadReporsScreen,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  // Implement your upload logic
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeHorizontalSize,
                      vertical: 0),
                  backgroundColor: CustomColor.uploadReporsScreen,
                ),
                child: Text(
                  'Upload',
                  style: GoogleFonts.poppins(
                    fontSize: Dimensions.headingTextSize5,
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? _image;
  XFile? pickedFile;

  Future<void> _pickImage() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile!.path);
        });
    }
  }
}
