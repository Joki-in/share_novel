import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> forgotPassword() async {
    const String apiUrl = Api.forgotPassword;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': emailController.text}),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);

      // Print response body
      print(response.body);

      if (response.statusCode == 200) {
        // OTP generated and email sent successfully
        showDialog(
          context: Get.overlayContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(
                  'OTP Sudah Dikirimkan ke Email Anda,silahkan cek email anda dan masukkan OTP yang diberikan'),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    // Save email to SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('email', emailController.text);
                    Get.toNamed('/otp');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Error handling
        final errorMessage = responseData['message'];
        Get.snackbar('Error', errorMessage);
      }
    } catch (error) {
      // Handle any errors that occur during the request
      // print(error.toString());
      Get.snackbar('Error', error.toString());
    }
  }
}
