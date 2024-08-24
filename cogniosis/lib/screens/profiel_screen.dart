import 'dart:io';

import 'package:cogniosis/screens/update_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/appConstant.dart';
import '../utils/app_colors.dart';
import '../utils/custom_color.dart';
import '../widgets/loading_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void getToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
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
          body:  SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage('assets/home/dummy-profile-pic.png'),
                      fit: BoxFit.cover
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: AppConstants.to.profilePic.value != ''
                        ? Image.network(AppConstants.to.profilePic.value,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/home/dummy-profile-pic.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppConstants.to.name.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Visibility(
                        visible: AppConstants.to.name.value.isNotEmpty && AppConstants.to.name.value != '',
                        child: ListTile(
                          leading: const Icon(Icons.person, size: 36),
                          title: Text('Full Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text(AppConstants.to.name.value, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Visibility(
                        visible: AppConstants.to.email.value.isNotEmpty && AppConstants.to.email.value != '',
                        child: ListTile(
                          leading: const Icon(Icons.email_rounded, size: 28),
                          title: Text('Email', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text(AppConstants.to.email.value, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Visibility(
                        visible: AppConstants.to.phone.value.isNotEmpty && AppConstants.to.phone.value != '',
                        child: ListTile(
                          leading: const Icon(Icons.phone_android_rounded, size: 28),
                          title: Text('Mobile Number', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text(AppConstants.to.phone.value, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Visibility(
                        visible: AppConstants.to.address.value.isNotEmpty && AppConstants.to.address.value != '',
                        child: ListTile(
                          leading: const Icon(Icons.location_on_rounded, size: 28),
                          title: Text('Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text(AppConstants.to.address.value, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Visibility(
                        visible: AppConstants.to.about.value.isNotEmpty && AppConstants.to.about.value != '',
                        child: ListTile(
                          leading: const Icon(Icons.account_box_outlined, size: 28),
                          title: Text('About', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text(AppConstants.to.about.value, textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Visibility(
                        visible: AppConstants.to.dob.value != DateTime(1970, 1, 1),
                        child: ListTile(
                          leading: const Icon(Icons.calendar_today_rounded, size: 26),
                          title: Text('Date of Birth', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey_txt)),
                          subtitle: Text("${AppConstants.to.dob.value!.day.toString().padLeft(2, '0')} / ${AppConstants.to.dob.value!.month.toString().padLeft(2, '0')} / ${AppConstants.to.dob.value!.year}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, color: AppColors.black_color, fontWeight: FontWeight.bold)),
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Get.to(const UpdateProfile()),
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        color: CustomColor.blueColor,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Center(
                      child: Text(
                        'Update Profile',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )

      );
    });
  }

}
