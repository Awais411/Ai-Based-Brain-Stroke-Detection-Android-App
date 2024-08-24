import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../functions/update_profile.dart';
import '../utils/appConstant.dart';
import '../utils/app_colors.dart';
import '../utils/custom_color.dart';
import '../widgets/custom_field.dart';
import '../widgets/loading_animation.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  RxBool loading = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    nameController.text = AppConstants.to.name.value ?? '';
    emailController.text = AppConstants.to.email.value ?? '';
    phoneController.text = AppConstants.to.phone.value ?? '';
    addressController.text = AppConstants.to.address.value ?? '';
    aboutController.text = AppConstants.to.about.value ?? '';
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void getToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  DateTime _selectedDate = AppConstants.to.dob.value;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      if (image.path.endsWith('.png') ||
          image.path.endsWith('.jpg') ||
          image.path.endsWith('.jpeg')) {
        setState(() {
          _imageFile = image;
        });
        print("Image picked: ${image.path}");
      } else {
        Get.snackbar(
          "Invalid Image",
          "Please select a PNG or JPG image.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } else {
      print("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: CustomColor.bluebg,
          appBar: AppBar(
            backgroundColor: CustomColor.bluebg,

            automaticallyImplyLeading: false,
            // backgroundColor: AppColors.black_color,
            title: Row(
              children: [
                // InkWell(
                //   onTap: () {
                //     print("sdsssssssssss222222222222sssssssssssss");
                //     _scaffoldKey.currentState!.openDrawer();
                //   },
                //   child: SvgPicture.asset(
                //     AppSvgImages.filter_img,
                //     width: 21.w,
                //     height: 20.h,
                //   ),
                // ),
                Spacer(),

                // RichText(
                //   text: TextSpan(
                //     text: 'Throx',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w800,
                //       fontSize: 16.sp,
                //       color: AppColors.black_color,
                //     ),
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: 'Scan',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w800,
                //           fontSize: 16.sp,
                //           color: AppColors.blue_color,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Text('My Profile'),
                Spacer(),
                // InkWell(
                //   // onTap: () => Get.to(() => NotificationScreen()),
                //   child: Icon(
                //     Icons.notifications,
                //     color: AppColors.blue_color,
                //     size: 20.sp,
                //   ),
                // ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: _imageFile != null
                                ? Image.file(
                                    File(_imageFile!.path),
                                    fit: BoxFit.cover,
                                  )
                                : AppConstants.to.profilePic.value != ''
                                    ? Image.network(
                                        AppConstants.to.profilePic.value,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/home/dummy-profile-pic.png",
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 33,
                              height: 33,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/home/pencil-icon.png",
                                  width: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppConstants.to.name.value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      AppConstants.to.email.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            textFieldTitle("Full Name"),
                            CustomTextField(
                              validator: (value) => checkEmptyField(value),
                              controller: nameController,
                              hintText: "Enter Your Name Here",
                              fontSize: 13,
                              txtColor: const Color(0xff391713),
                              horizPadding: 0,
                            ),
                            SizedBox(height: 20.h),
                            textFieldTitle("Mobile Number"),
                            CustomTextField(
                              controller: phoneController,
                              hintText: "Phone Number Here",
                              fontSize: 13,
                              txtColor: const Color(0xff391713),
                              horizPadding: 0,
                              inputType: TextInputType.phone,
                            ),
                            SizedBox(height: 20.h),
                            textFieldTitle("Address"),
                            CustomTextField(
                              controller: addressController,
                              hintText: "Address here",
                              fontSize: 13,
                              txtColor: const Color(0xff391713),
                              horizPadding: 0,
                              inputType: TextInputType.text,
                            ),
                            SizedBox(height: 20.h),
                            textFieldTitle("About"),
                            CustomTextField(
                              controller: aboutController,
                              hintText: "About me here",
                              fontSize: 13,
                              txtColor: const Color(0xff391713),
                              horizPadding: 0,
                              inputType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: textFieldTitle("Date of Birth"),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 46,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                _selectedDate == null
                                    ? "${AppConstants.to.dob.value!.day.toString().padLeft(2, '0')}/${AppConstants.to.dob.value!.month.toString().padLeft(2, '0')}/${AppConstants.to.dob.value!.year}"
                                    : "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          loading.value = true;

                          await updateProfile(
                            imageFile: _imageFile,
                            name: nameController.text.trim(),
                            address: addressController.text.trim(),
                            phone: phoneController.text.trim(),
                            about: aboutController.text.trim(),
                            dob: _selectedDate,
                            context: context,
                          );

                          loading.value = false;
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: CustomColor.blueColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Text(
                            'Update',
                            //  style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Visibility(
                visible: loading.value,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                      child: LoadingAnimation(color: Colors.white, size: 30)),
                ),
              )
            ],
          ));
    });
  }

  Widget textFieldTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              color: AppColors.grey_txt,
              fontSize: 13,
              fontWeight: FontWeight.bold)),
    );
  }

  String? checkEmptyField(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty.";
    }
    return null;
  }
}
