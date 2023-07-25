import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logingateways/consts/firebase_auth.dart';
import 'package:logingateways/profile_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../home_screen.dart';

class GoogleSignInController extends GetxController{

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        UserCredential userCredential = await googleAuthentication.signInWithCredential(credential);
        User? user = userCredential.user;

        // User is successfully signed in with Firebase
        // You can handle the signed-in user here

        // Save user details to Firestore
        await saveUser(user?.email ?? '', user?.displayName ?? '');

        VxToast.show(context, msg: 'Google login successful');
        Get.to(() => ProfileScreen());

        print('Signed in with Google! User: ${user?.displayName}');
      } catch (e) {
        // Handle any errors that occur during the sign-in process
        print('Error signing in with Google: $e');
      }
    }
  }

  void logoutGoogle(context)async{
    await googleSignIn.disconnect();
    await googleAuthentication.signOut();
    VxToast.show(context, msg: 'Logout successfully');
    Get.to(()=>HomeScreen());

  }



  Future<void> saveUser(String email, String displayName) async {
    try {
      // Check if user already exists in Firestore
      QuerySnapshot snapshot = await googleFirestore
          .collection(googleCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      // If user already exists, update their details
      if (snapshot.docs.isNotEmpty) {
        DocumentReference userRef = snapshot.docs.first.reference;
        await userRef.update({
          'name': displayName,
        });
      } else {
        // User does not exist, create a new document
        await googleFirestore.collection(googleCollection).add({
          'email': email,
          'name': displayName,
        });
      }

      print('User details saved to Firestore');
    } catch (e) {
      print('Error saving user details to Firestore: $e');
    }
  }



}