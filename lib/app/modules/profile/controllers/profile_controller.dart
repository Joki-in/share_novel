import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_novel/app/data/models/user_model.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/data/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final UserProvider _userProvider = Get.put(UserProvider());
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var alamatController = TextEditingController();
  Rx<User?> get user => _userProvider.user;
  Rx<File?> imageFile = Rx<File?>(null);
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
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
  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await _userProvider.fetchUser(token);
      } else {
        print('Token is null');
      }
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(Api.updateFotoProfile),
        );

        // Attach the file in the request
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          pickedFile.path,
        ));

        // Retrieve bearer token from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        // Add bearer token to the request headers if available
        if (token != null && token.isNotEmpty) {
          request.headers.addAll({
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
        }

        // Send the request
        var response = await request.send();

        // Read response
        var responseData = await response.stream.toBytes();
        var responseString = utf8.decode(responseData);

        // Check the status code of the response
        if (response.statusCode == 200) {
          print('Uploaded successfully');
          print('Response: $responseString');
          fetchUser();
        } else {
          print('Upload failed with status ${response.statusCode}');
          print('Response: $responseString');
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> updateProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        var uri = Uri.parse(Api.updateProfile);
        var requestHeaders = {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        };

        var requestBody = jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'alamat': alamatController.text,
        });

        var response =
            await http.put(uri, headers: requestHeaders, body: requestBody);

        if (response.statusCode == 200) {
          Get.snackbar(
            'Update Profile Success',
            'Profile updated successfully',
            backgroundColor: ColorConstant.Success,
            snackPosition: SnackPosition.BOTTOM,
          );
          fetchUser();
        } else if (response.statusCode >= 300 && response.statusCode < 400) {
          // Handle redirection (3xx) responses
          var location = response.headers['location'];
          if (location != null) {
            // Redirect to the new location
            var redirectedResponse = await http.post(Uri.parse(location),
                headers: requestHeaders, body: requestBody);
            if (redirectedResponse.statusCode == 200) {
              print('Profile updated successfully after redirection');
              fetchUser();
            } else {
              print(
                  'Failed to update profile after redirection: ${redirectedResponse.reasonPhrase}');
              Get.snackbar(
                'Update Profile Failed',
                'Failed to update profile after redirection: ${redirectedResponse.reasonPhrase}',
                backgroundColor: ColorConstant.Danger,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } else {
            print('Redirection location not found');
          }
        } else {
          print('Failed to update profile: ${response.reasonPhrase}');
          Get.snackbar(
            'Update Profile Failed',
            'Failed to update profile: ${response.reasonPhrase}',
            backgroundColor: ColorConstant.Danger,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        print('Token is null or empty');
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        'Error Updating Profile',
        'An error occurred while updating profile: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        var uri = Uri.parse(Api.logout); // Ganti dengan URL logout Anda
        var headers = {'Authorization': 'Bearer $token'};

        var response = await http.post(uri, headers: headers);

        if (response.statusCode == 200) {
          // Hapus token dari SharedPreferences
          await prefs.remove('token');

          // Navigasi ke halaman login (misalnya)
          Get.offAllNamed('/login');

          // Tampilkan pesan sukses
          Get.snackbar(
            'Logout Successful',
            'You have been successfully logged out',
            backgroundColor: ColorConstant.Success,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          // Tangani kesalahan jika permintaan gagal
          print('Failed to logout: ${response.statusCode}');
          print('Response: ${response.body}');
          Get.snackbar(
            'Error',
            'Failed to logout: ${response.reasonPhrase}',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Token tidak tersedia di SharedPreferences
        print('Token not found');
        Get.snackbar(
          'Error',
          'Token not found',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi kesalahan selama proses logout
      print('Error during logout: $e');
      Get.snackbar(
        'Error',
        'An error occurred during logout: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
