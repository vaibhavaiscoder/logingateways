import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/controllers/shared_pref_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedSignupPage extends StatefulWidget {
  @override
  _SharedSignupPageState createState() => _SharedSignupPageState();
}

class _SharedSignupPageState extends State<SharedSignupPage> {
  
  var controller = Get.put(SharedPrefController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: controller.confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.signupUsingShared(context),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
  
}

