import 'package:cogniosis/utils/appConstant.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<void> fetchUserData(BuildContext context) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String userUID = user.uid;
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUID)
          .get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;

        final ivBase64 = userData['iv'] as String?;
        final iv = ivBase64 != null
            ? encrypt.IV.fromBase64(ivBase64)
            : encrypt.IV.fromLength(16);

        final key = deriveKeyFromUid(userUID);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        void safeDecrypt(String fieldName, Function(String) setter) {
          try {
            if (userData.containsKey(fieldName) &&
                userData[fieldName] is String) {
              final encryptedValue = userData[fieldName] as String;
              final decryptedValue =
                  encrypter.decrypt64(encryptedValue, iv: iv);
              setter(decryptedValue);
            } else {
              setter(
                  ''); // Default empty value if the field is not present or invalid
            }
          } catch (e) {
            print('Error decrypting $fieldName: $e');
            setter(''); // Default empty value on error
          }
        }

        safeDecrypt('name', AppConstants.to.setName);
        AppConstants.to.setEmail(userData['email']!);
        if (userData.containsKey('profile_pic')) {
          AppConstants.to.setProfilePic(userData['profile_pic']!);
          precacheImage(
              NetworkImage(AppConstants.to.profilePic.value), context);
        }
        safeDecrypt('phone', AppConstants.to.setPhone);
        safeDecrypt('about', AppConstants.to.setAbout);
        safeDecrypt('address', AppConstants.to.setAddress);

        if (userData.containsKey('dob') && userData['dob'] is String) {
          try {
            final dobString = userData['dob'] as String;
            // Decrypt the DOB string
            final decryptedDobString = encrypter.decrypt64(dobString, iv: iv);
            // Parse decrypted date string to DateTime
            final dobDate = DateTime.tryParse(decryptedDobString);
            if (dobDate != null) {
              AppConstants.to.setDOB(dobDate);
            } else {
              print('Error parsing decrypted DOB: Invalid date format');
            }
          } catch (e) {
            print('Error decrypting or parsing DOB: $e');
          }
        }
      }
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
}

encrypt.Key deriveKeyFromUid(String uid) {
  final hash = sha256.convert(utf8.encode(uid)).bytes;
  return encrypt.Key.fromBase64(base64.encode(hash));
}
