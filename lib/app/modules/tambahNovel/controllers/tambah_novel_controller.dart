import 'dart:convert';

import 'package:get/get.dart';
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/data/provider/tambah_novelpage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TambahNovelController extends GetxController {
  final TambahNovelPageProvider _provider = TambahNovelPageProvider();

  final Rx<Search?> tambahNovelData = Rx<Search?>(null);
  Search? get tambahNovelValue => tambahNovelData.value;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTambahNovelData();
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
  Future<void> fetchTambahNovelData() async {
    final prefs = await SharedPreferences.getInstance();
    String? idUserString = prefs.getString('user_id');
    int idUser = int.tryParse(idUserString ?? '') ?? 0;
    try {
      final result = await _provider.fetchtambahnovelshow(idUser);
      if (result != null) {
        tambahNovelData.value = result;
      } else {
        Get.snackbar('Error', 'Failed to load search data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching search data: $e');
    }
  }

  void deleteDataByBukuId(int idBuku) async {
    try {
      Map<String, dynamic> data = {
        'id_buku': idBuku,
      };

      String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(Api.deleteNovel),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data has been deleted successfully');
      } else {
        Get.snackbar(
            'Error', 'Failed to delete data: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error deleting data: $e');
    }
    fetchTambahNovelData();
  }

  Future<void> loadData() async {
    await fetchTambahNovelData();
  }
}
