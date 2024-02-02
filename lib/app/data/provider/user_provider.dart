// user_provider.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/user_model.dart';
import 'dart:convert';

import 'package:share_novel/app/data/provider/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  Future<void> fetchUser(String token) async {
    final response = await http.post(
      Uri.parse(Api.profile),
      headers: {
        'Authorization': 'Bearer $token'
      }, // Sesuaikan format token di sini
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      user.value = User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
