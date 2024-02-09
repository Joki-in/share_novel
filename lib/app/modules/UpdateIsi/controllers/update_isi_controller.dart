import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/isi_provider.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

class UpdateIsiController extends GetxController {
  final TextEditingController isiTextfieldController = TextEditingController();
  final isiProvider = Get.put(IsiProvider());
  final TextEditingController chapterTextfieldController =
      TextEditingController();
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  var isidata = Isi().obs;
  late String id;
  late String chapter;
  late String isi;
  late int idBuku;
  late String check = '';
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Mendapatkan argument yang dibawa dari halaman sebelumnya
    Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null &&
        arguments.containsKey('id') &&
        arguments.containsKey('chapter') &&
        arguments.containsKey('isi')) {
      id = arguments['id'].toString();
      chapter = arguments['chapter'] ?? '';
      isi = arguments['isi'] ?? '';

      if (arguments.containsKey('id_buku')) {
        idBuku = arguments['id_buku'] ?? 0;
      } else {
        print('id_buku tidak ditemukan');
      }
      check = '0'; // Mengubah nilai check menjadi '0' di sini
      chapterTextfieldController.text = chapter;
      isiTextfieldController.text = isi;
    } else {
      check = '1';
      if (arguments!.containsKey('id_buku')) {
        idBuku = int.tryParse(arguments['id_buku']) ?? 0;
      } else {
        print('id_buku tidak ditemukan');
      }
    }
    print('id buku :$idBuku');
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
  Future<void> editIsi(String chapter, String isi) async {
    try {
      id = id;
      Map<String, dynamic> data = {
        'id': id,
        'chapter': chapter,
        'isi': isi,
      };

      // Kirim request ke API
      final response = await http.post(
        Uri.parse(Api.updateIsi),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        // Jika request berhasil
        Get.snackbar('Success', 'Data isi berhasil diperbarui',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromRGBO(134, 215, 137, 1));
        Get.offAllNamed('/isicreateshow', arguments: idBuku);
      } else {
        // Jika request gagal
        Get.snackbar('Error', 'Gagal memperbarui data isi',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorConstant.Danger);
      }
    } catch (e, stackTrace) {
      // Tangani jika terjadi error
      print('Error: $e');
      print('StackTrace: $stackTrace');
      Get.snackbar('Error', 'Gagal memperbarui data isi',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorConstant.Danger);
    }
  }

  Future<void> createIsi(String chapter, String isi) async {
    idBuku = idBuku;
    try {
      final response = await http.post(
        Uri.parse(Api.createIsi),
        body: jsonEncode({
          'id_buku': idBuku,
          'chapter': chapter,
          'isi': isi,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        Get.snackbar('Success', 'Data isi berhasil dibuat',
            backgroundColor: ColorConstant.Success,
            colorText: ColorConstant.WhiteColor);
        Get.offAllNamed('/isicreateshow', arguments: idBuku);
      } else {
        Get.snackbar('Error', 'Gagal membuat data isi',
            backgroundColor: ColorConstant.Danger,
            colorText: ColorConstant.WhiteColor);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Gagal membuat data isi',
          backgroundColor: ColorConstant.Danger,
          colorText: ColorConstant.WhiteColor);
    }
  }
}
