import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/profile_screen.dart';

import '../controllers/email_controller.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(EmailController());

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                // Add additional email validation if needed
                return null;
              },
            ),
            TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                // Add additional password validation if needed
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.loginMethod(context).then((value){

                  if (value!= null) {
                    Get.snackbar('Great', 'Logged in',snackPosition: SnackPosition.BOTTOM);
                    Get.offAll(() => const ProfileScreen());
                  } else{
                    Get.snackbar('Great', 'Logged Failed',snackPosition: SnackPosition.BOTTOM);
                  }
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.signUp();
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
