import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/profile_screen.dart';

import '../consts/firebase_auth.dart';

class PhoneSignUpController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  var otpController = List.generate(6, (index) => TextEditingController());



  // auth variables
  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID = '';

  //sendOtp method
  sendOtp(context) async {
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await phoneAuthentication.signInWithCredential(credential);
    };
    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        // print('The provided phone number is not valid.');
        Get.snackbar("The provided phone number is not valid", "please check entered number",
            snackPosition: SnackPosition.BOTTOM);
      }
    };
    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID = verificationId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {}
  }

  //verify otp
  verifyOtp(context) async {
    String otp = '';

    // getting all textfield data
    for (var i = 0; i < otpController.length; i++) {
      otp += otpController[i].text;
    }

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);

      // getting user
      final User? user =
          (await phoneAuthentication.signInWithCredential(phoneAuthCredential)).user;
      if (user != null) {

        await phoneFirestore
            .collection(phoneCollection)
            .doc(user.uid)
            .set({
          'id': user.uid,
          'phone': phoneController.text.toString(),
        });

        //showing toast of login
        Get.offAll(()=>const ProfileScreen(),transition: Transition.downToUp);
      }

    }catch(e){
      Get.snackbar('Error', 'Login Failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}