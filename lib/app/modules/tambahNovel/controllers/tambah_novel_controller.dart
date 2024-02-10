import 'dart:convert';

import 'package:flutter/material.dart';
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
  var judulTextfieldController = TextEditingController();
  var sinopsisTextfieldController = TextEditingController();
  RxInt i18 = 0.obs;
  RxString selectedValue = RxString('');
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

  void setSelectedValue(String value) {
    selectedValue.value = value;
    print(selectedValue.value);
  }

  void storeBuku() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? penulisId = prefs.getString('user_id');
      final judul = judulTextfieldController.text;
      final sinopsis = sinopsisTextfieldController.text;
      final genre = selectedValue.value;

      final response = await http.post(
        Uri.parse(Api.createNovel),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'judul': judul,
          'sinopsis': sinopsis,
          'penulis_id': penulisId,
          '18+': i18.value,
          'genre': genre,
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Data buku berhasil disimpan');
      } else {
        Get.snackbar('Error', 'Failed to store data: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error storing data: $e');
    }
    fetchTambahNovelData();
  }
}
