import 'package:get/get.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class NovelpagechapterProvider extends GetConnect {
  Future<Novelpagechapter> fetchNovelpagechapter(int idBuku) async {
    try {
      var response =
          await post(Api.novelPageChapter, {'id_buku': idBuku.toString()});

      if (response.status.hasError) {
        // print('Error: ${response.statusText}');
        throw 'Error fetching data';
      } else {
        final Map<String, dynamic> responseData = response.body;
        print('Response Body: $responseData');
        return Novelpagechapter.fromJson(responseData);
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
