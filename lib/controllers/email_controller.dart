import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logingateways/consts/firebase_auth.dart';
import 'package:logingateways/screens/email_auth_screen.dart';

class EmailController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  Future<UserCredential?> signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String name = nameController.text;
      String username = usernameController.text;
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();

      if (password == confirmPassword) {
        // Passwords match, perform signup logic
        UserCredential? userCredential;

        try {
          userCredential = await emailAuthentication.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Save user details to Firestore
         // await saveUser(email, password,name,username,phone);
          await saveUser(email,name,username,phone);
          Get.snackbar('Congo', 'Signup Success');
          Get.to(()=>EmailLogin());

        } on FirebaseAuthException catch (e) {
          Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM);
        }
        return userCredential;
      } else {
        Get.snackbar('Error', 'Passwords do not match');
      }

      //passwordless sign in email link

      // if (password == confirmPassword) {
      //   try {
      //     // Send email verification link
      //     await emailAuthentication.sendSignInLinkToEmail(
      //       email: email,
      //       actionCodeSettings: ActionCodeSettings(
      //         url: 'https://logingateways.page.link/y1E4',
      //         handleCodeInApp: true,
      //         androidPackageName: 'com.example.logingateways',
      //         androidInstallApp: true,
      //         // iOSBundleId: 'YOUR_IOS_BUNDLE_ID',
      //         dynamicLinkDomain: 'https://logingateways.page.link',
      //       ),
      //     );
      //
      //     // Save user details to Firestore
      //     await saveUser(email, name, username, phone);
      //
      //     Get.snackbar('Congratulations', 'Please check your email for the sign-in link.');
      //     Get.to(() => EmailLogin());
      //   } on FirebaseAuthException catch (e) {
      //     Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      //   }
      // } else {
      //   Get.snackbar('Error', 'Passwords do not match');
      // }
    }
  }


  // Future<void> saveUser(String email, String password,String name,String username,String phone) async {
  Future<void> saveUser(String email,String name,String username,String phone) async {
    // Create a Firestore instance
    try {
      // Add user details to Firestore
      await emailFirestore.collection(emailCollection).add({
        'email': email,
        // 'password': password,
        'name': name,
        'username': username,
        'phone': phone,
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //login method
  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;

    try {
      userCredential = await emailAuthentication.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return userCredential;
  }

}
