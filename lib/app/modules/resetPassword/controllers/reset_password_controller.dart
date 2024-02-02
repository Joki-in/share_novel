import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordController extends GetxController {
  RxBool showPassword = false.obs;
  final count = 0.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  final TextEditingController passwordController = TextEditingController();

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
  void toggleShowPassword() {
    showPassword.toggle();
  }

  bool arePasswordsMatching() {
    return password.value == confirmPassword.value;
  }

  void showPasswordMismatchSnackbar() {
    Get.snackbar(
      'Error',
      'Password and confirm password tidak sama silahkan check kembali',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> changePassword() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      final response = await http.post(
        Uri.parse(Api.resetPassword),
        body: jsonEncode({
          'email': email,
          'password': passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Password changed successfully
        Get.snackbar(
          'Succes',
          'Password telah diubah',
          backgroundColor: Colors.green,
          colorText: ColorConstant.WhiteColor,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed('/login');
      } else if (response.statusCode == 404) {
        // Email not found
        Get.snackbar('Error', 'Email not found');
      } else {
        // Other errors
        Get.snackbar('Error', 'An error occurred');
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
