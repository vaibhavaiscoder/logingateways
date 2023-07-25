import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/controllers/phone_controller.dart';
import 'package:logingateways/screens/phone_otp_screen.dart';

import '../profile_screen.dart';

class PhoneSignUp extends StatelessWidget {
  const PhoneSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(PhoneSignUpController());

    return Scaffold(
      appBar: AppBar(title: Text('Login with phone'),),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                labelText: 'phone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter number';
                }
                // Add additional email validation if needed
                return null;
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                if(controller.formKey.currentState!.validate()){
                  await controller.sendOtp(context);
                  await Get.to(()=>OtpVerificationScreen());
                }
                else{
                  Get.snackbar('Error', 'Failed to send otp');
                }
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
