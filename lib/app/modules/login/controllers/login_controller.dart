import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var obscureText = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> loginUser() async {
    final url = Uri.parse(Api.login);

    try {
      final email = emailController.text;
      final password = passwordController.text;

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}));

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final token = responseData['token'];

        // Simpan token ke SharedPreferences
        await saveTokenToSharedPreferences(token);

        Get.snackbar('Success', 'Login successful');
        Get.offAllNamed('/bottom-nav-bar');
      } else {
        final errorMessage = responseData['message'];
        Get.snackbar('Error', errorMessage);
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
