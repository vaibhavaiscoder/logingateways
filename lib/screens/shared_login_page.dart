import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:logingateways/controllers/shared_pref_controller.dart';


class SharedLoginPage extends StatefulWidget {
  @override
  _SharedLoginPageState createState() => _SharedLoginPageState();
}

class _SharedLoginPageState extends State<SharedLoginPage> {
  var controller = Get.put(SharedPrefController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: ()=> controller.sharedLogin(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }


}
