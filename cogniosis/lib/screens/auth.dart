import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../functions/fetch_user_data.dart';
import '../utils/appConstant.dart';
import 'login_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

        final key = deriveKeyFromUid(user.uid);
        final iv = encrypt.IV.fromLength(16);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));



        // Retrieve the existing user data from Firestore
        DocumentSnapshot userDocSnapshot = await userDocRef.get();

        // Prepare the data to update
        Map<String, dynamic> userData = {
          'name': encrypter.encrypt('${user.displayName}', iv: iv).base64,
          'email': user.email,
          'dob': encrypter.encrypt(DateTime(1970, 1, 1).toIso8601String(), iv: iv).base64,
          if(user.phoneNumber != null)
            'phone': encrypter.encrypt(user.phoneNumber!, iv: iv).base64,
          'profile_pic': user.photoURL,
          'iv' : iv.base64
        };

        // Remove fields that already exist and contain data in Firestore
        if (userDocSnapshot.exists) {
          Map<String, dynamic> existingData = userDocSnapshot.data() as Map<String, dynamic>;
          userData.removeWhere((key, value) => existingData.containsKey(key) && existingData[key] != null);
        }

        // Update Firestore with the remaining data
        await userDocRef.set(userData, SetOptions(merge: true));
      }

      return user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut().then(
            (value) {
          Get.offAll(() => const LoginScreen());
          AppConstants.to.setName('');
          AppConstants.to.setEmail('');
          AppConstants.to.setPhone('');
          AppConstants.to.setProfilePic('');
          AppConstants.to.setAddress('');
          AppConstants.to.setAbout('');
          AppConstants.to.setDOB(DateTime(1970, 1, 1));
          AppConstants.to.isGuest.value = false;
        },
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
