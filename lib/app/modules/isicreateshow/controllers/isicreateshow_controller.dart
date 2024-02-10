import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_novel/app/data/models/novelpagebuku_model.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/novel_page_buku_provider.dart';
import 'package:share_novel/app/data/provider/novel_page_chapter.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/provider/service.dart';

class IsicreateshowController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  late String bookId;
  var novelPageChapter = Novelpagechapter().obs;
  RxString judul = ''.obs;
  RxString sinopsis = ''.obs;
  RxInt i18 = 0.obs;
  RxString selectedValue = RxString('');

  Rx<Novelpagebuku> novelPageBuku = Novelpagebuku().obs;
  final NovelpagechapterProvider _novelpagechapterProvider =
      NovelpagechapterProvider();
  final NovelPageBukuProvider novelPageBukuProvider = NovelPageBukuProvider();
  var judulTextfieldController = TextEditingController();
  var sinopsisTextfieldController = TextEditingController();

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
    fetchNovelPageBuku();
    fetchNovelPageChapter();
    judulTextfieldController.text = novelPageBuku.value.bukus![0].judul!;
    sinopsisTextfieldController.text = novelPageBuku.value.bukus![0].sinopsis!;
    i18.value = novelPageBuku.value.bukus![0].i18 ?? 0;
    selectedValue.value = novelPageBuku.value.bukus?[0].genre ?? '';
    sinopsis.value = sinopsisTextfieldController.text;
    judul.value = judulTextfieldController.text;
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

  void fetchNovelPageBuku() async {
    try {
      final idBuku = int.tryParse(bookId);
      if (idBuku != null) {
        final novelpagebuku =
            await novelPageBukuProvider.getBukuDanPenulis(idBuku);
        novelPageBuku.value = novelpagebuku;
      } else {
        throw Exception("Invalid bookId format");
      }
    } catch (e) {
      print("Error fetching novel page buku: $e");
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

  void setSelectedValue(String value) {
    selectedValue.value = value;
    print(selectedValue.value);
  }

  Future<void> pickImage() async {
    final idBuku = bookId;
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(Api.updateCover),
        );

        request.files.add(await http.MultipartFile.fromPath(
          'cover',
          pickedFile.path,
        ));

        request.fields['id'] = idBuku;

        var response = await request.send();

        var responseData = await response.stream.toBytes();
        var responseString = utf8.decode(responseData);

        if (response.statusCode == 200) {
          print('Uploaded successfully');
          print('Response: $responseString');
          fetchNovelPageBuku();
        } else {
          print('Upload failed with status ${response.statusCode}');
          print('Response: $responseString');
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> updateBuku() async {
    try {
      final idBuku = int.tryParse(bookId);
      if (idBuku != null) {
        var response = await http.post(
          Uri.parse(Api.updateNovel),
          body: {
            'id': idBuku.toString(),
            'judul': judulTextfieldController.text,
            'sinopsis': sinopsisTextfieldController.text,
            'genre': selectedValue.value,
            '18+': i18.value.toString(),
          },
        );

        if (response.statusCode == 200) {
          Get.snackbar('Success', 'Data buku berhasil diupdate');
        } else {
          Get.snackbar('Error', "${response.statusCode}");
        }
      } else {
        throw Exception("Invalid bookId format");
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal terhubung ke server ');
      print('Error: $e');
    }
    fetchNovelPageBuku();
    fetchNovelPageChapter();
  }
}
