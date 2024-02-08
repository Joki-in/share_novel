import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class TambahNovelPageProvider {
  Future<Search?> fetchtambahnovelshow(int idUser) async {
    try {
      final response = await http.post(
        Uri.parse(Api.tambahNovelShow),
        body: {'id_user': idUser.toString()}, // Tambahkan body di sini
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
