import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider {
  Future<Search?> fetchSearchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? umur = prefs.getInt('umur'); // Ambil nilai umur sebagai integer
      final response = await http.post(
        Uri.parse(Api.search),
        body: json.encode({
          'umur':
              umur.toString(), // Ubah nilai umur menjadi string sebelum dikirim
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Search.fromJson(jsonData);
      } else {
        print('bodynya ${response.body}');
        throw Exception('Failed to load search data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching search data: $e');
      return null; // Return null if there's an error
    }
  }
}
