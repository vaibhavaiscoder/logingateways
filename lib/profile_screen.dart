import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logingateways/consts/firebase_auth.dart';
import 'package:logingateways/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'controllers/google_auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(GoogleSignInController());

    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                emailAuthentication.signOut();
                VxToast.show(context, msg: 'email logout successfull');
                Get.to(()=>HomeScreen());
              },
              child: Text('email Logout')
            ),ElevatedButton(
              onPressed: () {
                phoneAuthentication.signOut();
                VxToast.show(context, msg: 'phone logout successfull');
                Get.to(()=>HomeScreen());
              },
              child: Text('phone Logout')
            ),ElevatedButton(
              onPressed: () async{
                controller.logoutGoogle(context);
                // await controller.googleSignIn.disconnect();
                // await googleAuthentication.signOut();
                // VxToast.show(context, msg: 'google logout successfull');
                // Get.to(()=>HomeScreen());
              },
              child: Text('google Logout')
            ),
          ],
        ),
      ),
    );
  }
}
