import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/isi_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class IsiProvider extends GetxService {
  Future<Isi> fetchIsiByIdBuku(int id) async {
    try {
      final response = await http.post(
        Uri.parse(Api.isi), // Ganti dengan endpoint API Anda
        body: {'id': id.toString()},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Isi.fromJson(jsonData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
