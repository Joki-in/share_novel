import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/forgotPassword/controllers/forgot_password_controller.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Otp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Masukkan OTP yang dikirimkan ke email anda',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 4,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                // Handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                controller.checkOTP(verificationCode);
              }, // end onSubmit
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
