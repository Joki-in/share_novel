import 'dart:convert';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';
import 'package:intl/intl.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  var obscureText = true.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  var loading = false.obs;

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

  void isPasswordMatch() {
    if (passwordController.text == confirmPasswordController.text) {
      registerUser();
    } else {
      Get.snackbar("error", "Password tidak sama",
          snackPosition: SnackPosition.TOP,
          backgroundColor: ColorConstant.Danger,
          colorText: ColorConstant.WhiteColor);
    }
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> registerUser() async {
    try {
      loading.value = true;
      final response = await http.post(
        Uri.parse(Api.register),
        body: json.encode({
          'name': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'alamat': alamatController.text,
          'tanggal_lahir': tanggalLahirController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body); // Print response body

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', emailController.text);
        // Registration successful
        Get.dialog(
          AlertDialog(
            title: Text('Success'),
            content: Text('User registered Behasil Silahkan Login'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offAllNamed('/otp-register');
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
      loading.value = false;
    } catch (error) {
      // Handle any errors that occur during the registration process
      loading.value = false;
      print(error.toString());
      Get.snackbar('Error', 'Failed to register user');
    }
  }

  void showBirthDateDialog(BuildContext context) async {
    DateTime selectedDate =
        DateTime.now(); // Tanggal awal default adalah tanggal saat ini

    final DateTime? pickedDate = await showDatePickerDialog(
      context: context,
      initialDate: selectedDate,
      minDate: DateTime(1900, 1, 1),
      maxDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      tanggalLahirController.text = formattedDate;
      // Lakukan sesuatu dengan tanggal lahir yang dipilih
      print('Selected birth date: $formattedDate');
    }
  }
}
