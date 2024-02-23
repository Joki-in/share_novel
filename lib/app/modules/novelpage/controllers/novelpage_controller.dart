import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/komentarmodel_model.dart';
import 'package:share_novel/app/data/models/novelpagebuku_model.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/komentar_provider.dart';
import 'package:share_novel/app/data/provider/novel_page_buku_provider.dart';
import 'package:share_novel/app/data/provider/novel_page_chapter.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovelpageController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  RxList<String> comments = <String>[].obs;
  Rx<Novelpagebuku> novelPageBuku = Novelpagebuku().obs;
  RxList<Komentar> komentarList = <Komentar>[].obs;
  var novelPageChapter = Novelpagechapter().obs;
  RxString statuslike = ''.obs;
  RxString batasan_buku = ''.obs;
  late String bookId;
  final TextEditingController commentTextController = TextEditingController();

  final KomentarProvider komentarProvider = KomentarProvider();
  final NovelPageBukuProvider novelPageBukuProvider = NovelPageBukuProvider();
  final NovelpagechapterProvider _novelpagechapterProvider =
      NovelpagechapterProvider();

  bool isPosting = false;
  int statuscode = 0;

  @override
  void onInit() {
    super.onInit();
    final dynamic arguments = Get.arguments;
    if (arguments is int) {
      bookId = arguments.toString();
    } else if (arguments is String) {
      bookId = arguments;
    } else {
      throw Exception("Invalid argument type");
    }

    tambahView();
    checkLike();
    fetchNovelPageChapter();
    fetchNovelPageBuku();
    fetchKomentarByBukuId(int.tryParse(bookId) ?? 0);
  }

  Future<void> fetchKomentarByBukuId(int idBuku) async {
    try {
      final komentar = await komentarProvider.getKomentarByBukuId(idBuku);
      if (komentar != null) {
        komentarList.assignAll(komentar);
      } else {
        throw Exception("Failed to fetch komentar");
      }
    } catch (e) {
      print("Error fetching komentar: $e");
    }
  }

  Future<void> createLike() async {
    final idBuku = int.tryParse(bookId);
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    try {
      final response = await http.post(
        Uri.parse(Api.pushLike),
        body: jsonEncode({
          'id_buku': idBuku,
          'id_user': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body);
    } catch (e) {
      throw Exception('Failed to create like: $e');
    }
    checkLike();
    fetchNovelPageBuku();
    update();
  }

  Future<void> unLike() async {
    final idBuku = int.tryParse(bookId);
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    try {
      final response = await http.post(
        Uri.parse(Api.pushUnlike),
        body: jsonEncode({
          'id_buku': idBuku,
          'id_user': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body);
    } catch (e) {
      throw Exception('Failed to unlike: $e');
    }
    checkLike();
    fetchNovelPageBuku();
    update();
  }

  Future<void> checkLike() async {
    final idBuku = int.tryParse(bookId);
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    try {
      final response = await http.post(
        Uri.parse(Api.checklike),
        body: {
          'id_buku': idBuku.toString(),
          'id_user': userId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.body);
        if (data['status'] == 'like') {
          statuslike.value = 'like';
        } else {
          statuslike.value = 'none';
        }
      } else {
        print(response.body);
        statuslike.value = 'error';
      }
    } catch (e) {
      statuslike.value = 'error';
    }
  }

  void fetchNovelPageBuku() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? umur = prefs.getInt('umur');
      final idBuku = int.tryParse(bookId);
      if (idBuku != null) {
        final novelpagebuku =
            await novelPageBukuProvider.getBukuDanPenulis(idBuku);
        novelPageBuku.value = novelpagebuku;
        batasan_buku = novelpagebuku.bukus![0].i18.toString().obs;
        print('$umur = $batasan_buku');
        if ((umur! <= 0 || umur! < 18) && batasan_buku == '1') {
          Get.defaultDialog(
            title: "Peringatan",
            content: Text("Anda belum cukup umur."),
          );
          await Future.delayed(Duration(seconds: 2));

          Get.offAllNamed('/bottom-nav-bar');
        }
      } else {
        throw Exception("Invalid bookId format");
      }
    } catch (e) {
      print("Error fetching novel page buku: $e");
    }
  }

  void tambahView() async {
    try {
      final idBuku = int.tryParse(bookId);
      final response = await http.post(
        Uri.parse(Api.pushView),
        body: {'id_buku': idBuku.toString()},
      );

      if (response.statusCode == 200) {
        print('View added successfully');
      } else {
        print('Failed to add view');
      }
    } catch (e) {
      print('Error: $e');
    }
    update();
  }

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

  Future<void> postKomentar() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getString('user_id');

    if (idUser == null || idUser.isEmpty) {
      print('Error: user_id is null or empty in SharedPreferences');
      return;
    }

    final idBuku = int.tryParse(bookId)?.toString();

    try {
      final response = await http.post(
        Uri.parse(Api.postKomentar),
        body: {
          'id_buku': idBuku,
          'id_user': idUser,
          'komentar': commentTextController.text,
        },
      );
      if (response.statusCode == 201) {
        commentTextController.clear();

        print('Komentar created successfully');
      } else {
        print('Failed to create komentar');
      }

      statuscode = response.statusCode;
    } catch (e) {
      print('Error: $e');
    }

    fetchKomentarByBukuId(int.tryParse(idBuku ?? '') ?? 0);
    update();
  }
}
