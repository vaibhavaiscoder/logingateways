import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/profile_screen.dart';
import 'package:logingateways/screens/shared_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SharedPrefController extends GetxController{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signupUsingShared(context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      VxToast.show(context, msg: 'Please fill all fields.');
      return;
    }

    if (password != confirmPassword) {
      VxToast.show(context, msg: 'Passwords do not match.');
      return;
    }

    // Save user details to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);

    VxToast.show(context, msg: 'Signup successful.');

    Get.to(()=> SharedLoginPage());
  }

  void sharedLogin(context) async {
    final name = nameController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || password.isEmpty) {
      VxToast.show(context, msg: 'Please fill all fields.');

      return;
    }

    // Retrieve user details from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name');
    final storedPassword = prefs.getString('password');

    if (name == storedName && password == storedPassword) {
      VxToast.show(context, msg: 'Login successful.');

      Get.to(()=>const ProfileScreen());
    } else {
      VxToast.show(context, msg: 'Invalid name or password.');

    }
  }


}