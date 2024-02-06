import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/novelpagebuku_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class NovelPageBukuProvider {
  Future<Novelpagebuku> getBukuDanPenulis(int idBuku) async {
    final url =
        Uri.parse(Api.novelPageBuku); // Ganti dengan URL endpoint API Anda

    try {
      final response =
          await http.post(url, body: {'id_buku': idBuku.toString()});

      if (response.statusCode == 200) {
        // Jika respons berhasil
        final responseData = jsonDecode(response.body);
        print(response.body);
        return Novelpagebuku.fromJson(responseData);
      } else {
        // Jika respons tidak berhasil
        throw Exception(
            'Failed to load data: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // Tangani error jika terjadi
      throw Exception('Error: $e');
    }
  }
}
