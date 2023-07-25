import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logingateways/controllers/email_controller.dart';
import 'package:logingateways/screens/email_auth_screen.dart';

class EmailSignUp extends StatelessWidget {
  const EmailSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(EmailController());

    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
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
              ),TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Name';
                  }
                  // Add additional email validation if needed
                  return null;
                },
              ),TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Username';
                  }
                  // Add additional email validation if needed
                  return null;
                },
              ),TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an mobile number';
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
              TextFormField(
                controller: controller.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  // Add additional password confirmation validation if needed
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.signUp();
                },
                child: Text('Sign up'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(()=>EmailLogin());
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
