import 'dart:async';

import 'package:cogniosis/custom_bottom_navigation_bar.dart';
import 'package:cogniosis/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../functions/fetch_user_data.dart';
import '../utils/basic_screen_imports.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is signed in, navigate to HomeScreen
      Timer(
        const Duration(seconds: 1),
        () async {
          await fetchUserData(context);
          Get.offAll(const CustomBottomNavigationBar());
        },
      );
    } else {
      // No user is signed in, navigate to LoginScreen
      Timer(const Duration(seconds: 3), () => Get.offAll(const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.blueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo.png', height: 200.h, width: 200.w),
            SizedBox(height: Dimensions.heightSizelarge),
            Text(
              "Welcome to",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            CustomText(
              firstPart: 'Cognio',
              secondPart: 'sis',
              firstPartStyle: Theme.of(context).textTheme.headlineLarge,
              secondPartStyle: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: CustomColor.sykBlue),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              "Brain Stroke detection application",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: CustomColor.whiteColor),
            ),
            SizedBox(height: Dimensions.heightSizelarge * 2),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              "Loading",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: CustomColor.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
