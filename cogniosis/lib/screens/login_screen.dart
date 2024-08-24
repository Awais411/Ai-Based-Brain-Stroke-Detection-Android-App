import 'package:cogniosis/custom_bottom_navigation_bar.dart';
import 'package:cogniosis/screens/signup_screen.dart';
import 'package:cogniosis/widgets/loading_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../functions/fetch_user_data.dart';
import '../utils/basic_screen_imports.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_button.dart';
import 'email_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      // Navigate to the home screen upon successful login
      Get.snackbar('Success', 'Account Logged in Successfully',
          backgroundColor: Colors.lightGreenAccent,
          snackPosition: SnackPosition.BOTTOM);
      await fetchUserData(context);
      Get.offAll((const CustomBottomNavigationBar()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        Get.snackbar('Error', 'Failed to Login',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        print(e.message!);
        // _errorMessage = e.message!;
      });
    }
  }

  RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  // "Sign in to your Account" Text
                  SizedBox(
                    height: 40.h,
                    child: Text(
                      'Sign in to your Account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSizelarge),
                  // Email/Phone# TextField
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email...',
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  // Password TextField
                  TextField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Password...',
                    ),
                    obscureText: true, // Hide password text
                  ),
                  SizedBox(height: Dimensions.heightSizelarge),
                  // Continue Button
                  SizedBox(
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () async {
                        loading.value = true;
                        bool valid = validateMyFields(context, [
                          email,
                          password,
                          if (password.text.length < 6) password,
                        ], [
                          "Email",
                          "Password",
                          "Password must be 6 digit long ",
                        ]);
                        if (!valid) {
                          return;
                          loading.value = false;
                        }
                        await _login();
                        loading.value = false;
                      },
                      child: const SizedBox(
                        // width: 110.w,
                        child: Text(
                          'Continue',
                          //  style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  // "New Here? Create Account" TextButton
                  CustomTextButton(
                      firstPart: "Don't have an account?  ",
                      secondPart: "Sign up",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
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
