import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../custom_bottom_navigation_bar.dart';
import '../functions/fetch_user_data.dart';
import '../utils/app_colors.dart';
import '../utils/basic_screen_imports.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/loading_animation.dart';
import 'login_screen.dart';

class EmailPassword extends StatefulWidget {
  const EmailPassword({super.key});

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColor.blueColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
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
                        firstPartStyle:
                            Theme.of(context).textTheme.headlineLarge,
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
                        'Register to your Account',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSizelarge),
                    // Email/Phone# TextField
                    TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                        hintText: 'First name',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    TextField(
                      controller: lastName,
                      decoration: InputDecoration(
                        hintText: 'Last name',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    TextField(
                      controller: about,
                      decoration: InputDecoration(
                        hintText: 'About me',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    TextField(
                      controller: address,
                      decoration: InputDecoration(
                        hintText: 'Address',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    TextField(
                      controller: mobile,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Mobile no.',
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: TextField(
                        controller: dob,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Date of birth',
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    // Password TextField
                    GestureDetector(
                      child: TextField(
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSizelarge),
                    // Continue Button
                    SizedBox(
                      width: 150.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          loading.value = true;
                          await _register();
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
                    SizedBox(height: Dimensions.heightSizelarge),
                    // "Already have Account, Log in" TextButton
                    CustomTextButton(
                        firstPart: "Already Have Account,",
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

  encrypt.Key deriveKeyFromUid(String uid) {
    final hash = sha256.convert(utf8.encode(uid)).bytes;
    return encrypt.Key.fromBase64(base64.encode(hash));
  }

  Future<void> _register() async {
    bool valid = validateMyFields(context, [
      firstName,
      lastName,
      email,
      dob,
      password,
      if (password.text.length < 6) password,
    ], [
      "First name",
      "Last name",
      "Email",
      "Date of birth",
      "Password",
      "Password must be 6 digits long",
    ]);

    if (!valid) {
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await userCredential.user!
          .updateDisplayName('${firstName.text} ${lastName.text}');
      await userCredential.user!.reload();
      User? updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null) {
        final key = deriveKeyFromUid(updatedUser.uid);
        final iv = encrypt.IV.fromLength(16);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        final Map<String, dynamic> userData = {};

        if (firstName.text.isNotEmpty || lastName.text.isNotEmpty) {
          userData['name'] = encrypter
              .encrypt('${firstName.text} ${lastName.text}', iv: iv)
              .base64;
        }
        if (_selectedDate != null) {
          userData['dob'] = encrypter
              .encrypt(_selectedDate!.toIso8601String(), iv: iv)
              .base64;
        }
        if (email.text.isNotEmpty) {
          userData['email'] = email.text;
        }
        if (about.text.isNotEmpty) {
          userData['about'] = encrypter.encrypt(about.text, iv: iv).base64;
        }
        if (address.text.isNotEmpty) {
          userData['address'] = encrypter.encrypt(address.text, iv: iv).base64;
        }
        if (mobile.text.isNotEmpty) {
          userData['phone'] = encrypter.encrypt(mobile.text, iv: iv).base64;
        }

        if (userData.isNotEmpty) {
          userData['iv'] = iv.base64;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userData);
        await fetchUserData(context);
        Get.snackbar('Success', 'Account Created Successfully!',
            colorText: Colors.white);
        Get.offAll(const CustomBottomNavigationBar());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.',
            colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.',
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? 'Signup failed, please try again!',
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.',
          colorText: Colors.white);
    }
  }

  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked);
        _selectedDate = picked;
      });
    }
  }
}

void showSnackbar(String message, Color color, [int duration = 4000]) {
  final snackBar = GetSnackBar(
    // behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(8),
    backgroundColor: color,
    borderRadius: 4,
    message: message,
    duration: Duration(milliseconds: duration),
    // content: Text(message),
  );
  Get.showSnackbar(snackBar);
}

bool validateMyFields(BuildContext context,
    List<TextEditingController> controllerList, List<String> fieldsName) {
  for (int i = 0; i < controllerList.length; i++) {
    if (controllerList[i].text.trim().isEmpty) {
      showSnackbar("${fieldsName[i].toString()} can't be empty", Colors.red);
      i = controllerList.length + 1;
      return false;
    }
  }
  return true;
}
