import 'package:get/get.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/novel_page_chapter.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';

class IsicreateshowController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  late String bookId;
  var novelPageChapter = Novelpagechapter().obs;
  final NovelpagechapterProvider _novelpagechapterProvider =
      NovelpagechapterProvider();
  final count = 0.obs;
  @override
  void onInit() {
    final dynamic arguments = Get.arguments;
    if (arguments is int) {
      bookId = arguments.toString();
    } else if (arguments is String) {
      bookId = arguments;
    } else {
      throw Exception("Invalid argument type");
    }
    fetchNovelPageChapter();
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
  void fetchNovelPageChapter() async {
    try {
      final idBuku = int.tryParse(bookId);
      final response =
          await _novelpagechapterProvider.fetchNovelpagechapter(idBuku ?? 0);

      novelPageChapter.value = response;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteIsiById(String isiId) async {
    try {
      final response =
          await http.post(Uri.parse(Api.deleteIsi), body: {'isi_id': isiId});
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data Isi berhasil dihapus');
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', 'Data Isi tidak ditemukan');
      } else {
        Get.snackbar('Error', 'Terjadi kesalahan saat menghapus data Isi');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal terhubung ke server');
      print('Error: $e');
    }
    fetchNovelPageChapter();
  }
}
