import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRegisterController extends GetxController {
  //TODO: Implement OtpRegisterController

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

  Future<void> checkOTP(String otp) async {
    try {
      // Endpoint API
      const String apiUrl = Api.otp;
      final prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      // Membuat request
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {'Content-Type': 'application/json'},
      );

      // Mendapatkan response body
      final responseData = json.decode(response.body);

      // Memeriksa status kode response
      if (response.statusCode == 200) {
        // Sukses, tampilkan pesan sukses

        showDialog(
          context: Get.overlayContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/succes.json', // ganti dengan path ke file animasi Lottie Anda
                    width: 300,
                    height: 300,
                    repeat: false,
                    animate: true,
                  ),
                  Text(
                    'Silahkan masukkan password baru Anda',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Center(child: Text('OK')),
                ),
              ],
            );
          },
        );
      } else {
        // Terjadi kesalahan, tampilkan pesan kesalahan
        final errorMessage = responseData['message'];
        Get.snackbar('Error', errorMessage);
      }
    } catch (error) {
      // Handle error saat melakukan request
      Get.snackbar('Error', 'An error occurred: $error');
    }
  }
}
