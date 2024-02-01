import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  var obscureText = true.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  Future<void> registerUser() async {
    try {
      final response = await http.post(
        Uri.parse(Api.register),
        body: json.encode({
          'name': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'alamat': alamatController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body); // Print response body

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        // Registration successful
        Get.dialog(
          AlertDialog(
            title: Text('Success'),
            content: Text('User registered Behasil Silahkan Login'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offAllNamed('/login'); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Registration failed
        final errorMessage =
            responseData['errors']['email'] ?? 'Failed to register user';
        Get.snackbar('Error', errorMessage.toString());
      }
    } catch (error) {
      // Handle any errors that occur during the registration process
      print(error.toString());
      Get.snackbar('Error', 'Failed to register user');
    }
  }
}
