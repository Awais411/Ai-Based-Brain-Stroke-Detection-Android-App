import 'package:cogniosis/screens/login_screen.dart';
import 'package:cogniosis/utils/appConstant.dart';
import 'package:cogniosis/widgets/custom_text_button.dart';
import 'package:get/get.dart';

import '../custom_bottom_navigation_bar.dart';
import '../functions/fetch_user_data.dart';
import '../utils/basic_screen_imports.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_animation.dart';
import 'auth.dart';
import 'email_password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController password = TextEditingController();

  RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: CustomColor.blueColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo Placeholder
                  Image.asset(
                    'assets/logo/logo.png',
                    height: 200.h,
                    width: 200.w,
                  ),

                  SizedBox(height: Dimensions.heightSizelarge),
                  // "Cogniosis" Text
                  Center(
                    child: CustomText(
                      firstPart: 'Cognio',
                      secondPart: 'sis',
                      firstPartStyle: Theme.of(context).textTheme.headlineLarge,
                      secondPartStyle: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: CustomColor.sykBlue),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSizelarge),
                  // "Continue With Google" Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize,
                        vertical: 0),
                    child: GestureDetector(
                      onTap: () async {
                        loading.value = true;
                        await AuthService()
                            .signInWithGoogle()
                            .then((user) async {
                          if (user != null) {
                            await fetchUserData(context);
                            Get.snackbar('Success', 'Login Successfully!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lightGreenAccent);
                            Get.offAll((const CustomBottomNavigationBar()));
                          }
                        });
                        loading.value = false;
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/logo/GOOGLE.png'),
                            const Spacer(),
                            Text(
                              'Continue With Google',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: CustomColor.blackColor),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize,
                        vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(EmailPassword());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'assets/Gmail new logo.png',
                              height: 30,
                            ),
                            const Spacer(),
                            Text(
                              'Continue With Email',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: CustomColor.blackColor),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize,
                        vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(EmailPassword());
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: CustomColor.lightBlue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.facebook,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Text(
                              'Continue With Facebook',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize,
                        vertical: 0),
                    child: const Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 3,
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Text('or'),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 3,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // "Continue As Guest" Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize,
                        vertical: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        AppConstants.to.isGuest.value = true;
                        Get.offAll(const CustomBottomNavigationBar());

                        // Add onPressed functionality
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.darkRed),
                      child: Text(
                        'Continue As Guest',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSizelarge),
                  // "Already have Account, Log in" TextButton
                  CustomTextButton(
                      firstPart: "Already Have Account,   ",
                      secondPart: "Log in",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      })
                ],
              ),
            ),
            Visibility(
              visible: loading.value,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                    child: LoadingAnimation(color: Colors.white, size: 40)),
              ),
            )
          ],
        ),
      );
    });
  }
}
