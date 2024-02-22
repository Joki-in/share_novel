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

  final isLoading = false
      .obs; // Variabel untuk menunjukkan apakah proses login sedang berlangsung

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

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> loginUser() async {
    isLoading.value =
        true; // Atur isLoading menjadi true saat proses login dimulai

    final url = Uri.parse(Api.login);

    try {
      final prefs = await SharedPreferences.getInstance();
      String? tokenFCM = prefs.getString('fcmToken');
      final email = emailController.text;
      final password = passwordController.text;

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {'email': email, 'password': password, 'fcm_token': tokenFCM}));

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['status_regis'] == '1') {
          final token = responseData['token'];
          final userId = responseData['user_id'];
          final umur = responseData['umur'];

          await saveTokenToSharedPreferences(token, userId, umur);

          Get.snackbar('Success', 'Login successful',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.offAllNamed('/bottom-nav-bar');
        } else {
          Get.snackbar('Error',
              'akun anda belum terverifikasi,silahkan check email atau hubungi admin',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        final errorMessage = responseData['message'];
        Get.snackbar('Error', errorMessage);
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value =
          false; // Atur isLoading menjadi false setelah proses login selesai
    }
  }

  Future<void> saveTokenToSharedPreferences(
      String token, int userId, int umur) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user_id', userId.toString());
    await prefs.setInt('umur', umur);
  }
}
