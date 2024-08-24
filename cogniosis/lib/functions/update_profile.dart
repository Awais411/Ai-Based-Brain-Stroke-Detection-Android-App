import 'dart:io';

import 'package:cogniosis/screens/profiel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'fetch_user_data.dart';

Future<void> updateProfile({
  required BuildContext context,
  XFile? imageFile,
  required String name,
  required String address,
  required String about,
  required String phone,
  required DateTime dob,
}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final key = deriveKeyFromUid(user.uid);
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final Map<String, dynamic> updates = {};

      if (name.isNotEmpty) {
        updates['name'] = encrypter.encrypt(name, iv: iv).base64;
      }
      if (address.isNotEmpty) {
        updates['address'] = encrypter.encrypt(address, iv: iv).base64;
      }
      if (about.isNotEmpty) {
        updates['about'] = encrypter.encrypt(about, iv: iv).base64;
      }
      if (phone.isNotEmpty) {
        updates['phone'] = encrypter.encrypt(phone, iv: iv).base64;
      }
      updates['dob'] = encrypter.encrypt(dob.toIso8601String(), iv: iv).base64;
      updates['iv'] = iv.base64;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updates);

      if (imageFile != null) {
        String imageUrl = await updateProfilePic(File(imageFile.path));
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profile_pic': imageUrl,
        });
      }

      Get.snackbar("Success", "Profile updated successfully",
          colorText: Colors.white);
      await fetchUserData(context);
      Get.off(const ProfileScreen());
    }
  } catch (e) {
    print("Error updating profile: $e");
    Get.snackbar("Error", "Failed to update profile", colorText: Colors.white);
  }
}

Future<String> updateProfilePic(File imageFile) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  String fileName = "profilePic.jpg";
  Reference firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child('profilePics')
      .child(user.uid)
      .child(fileName);

  try {
    // Upload file to Firebase Storage
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get download URL
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading profile picture: $e');
    throw Exception('Failed to upload profile picture');
  }
}
