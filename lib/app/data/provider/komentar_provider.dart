import 'package:get/get.dart';
import 'package:share_novel/app/data/models/komentarmodel_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class KomentarProvider extends GetConnect {
  Future<List<Komentar>?> getKomentarByBukuId(int idBuku) async {
    try {
      final response = await post(
        Api.novelPageKomentar,
        {'id_buku': idBuku.toString()},
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData['status'] == 'success') {
          List<dynamic> data = responseData['komentar'];
          return data.map((item) => Komentar.fromJson(item)).toList();
        } else {
          throw Exception('Failed to load komentar');
        }
      } else {
        throw Exception('Failed to load komentar');
      }
    } catch (e) {
      throw Exception('Failed to load komentar: $e');
    }
  }
}
