import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/controllers/google_auth_controller.dart';
import 'package:logingateways/screens/email_signup_screen.dart';
import 'package:logingateways/screens/phone_sign_up.dart';
import 'package:logingateways/screens/shared_signup_page.dart';
import 'package:velocity_x/velocity_x.dart';

import 'consts/firebase_auth.dart';
import 'controllers/phone_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GoogleSignInController());

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Any Login Method',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Align(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => EmailSignUp());
              },
              child: Text('Email'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => PhoneSignUp());
              },
              child: Text('phone'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.signInWithGoogle(context);
               },
              child: Text('google'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SharedSignupPage());
              },
              child: Text('shared preferences'),
            ),
          ]),
        ));
  }
}
