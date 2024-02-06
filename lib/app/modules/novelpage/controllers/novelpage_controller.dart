import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/novelpagebuku_model.dart';
import 'package:share_novel/app/data/models/novelpagechapter_model.dart';
import 'package:share_novel/app/data/provider/novel_page_buku_provider.dart';
import 'package:share_novel/app/data/provider/novel_page_chapter.dart';
import 'package:share_novel/app/data/provider/service.dart';

class NovelpageController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  RxList<String> comments = <String>[].obs;
  final TextEditingController commentTextController = TextEditingController();
  Rx<Novelpagebuku> novelPageBuku = Novelpagebuku().obs;
  final NovelPageBukuProvider novelPageBukuProvider = NovelPageBukuProvider();
  final NovelpagechapterProvider _novelpagechapterProvider =
      NovelpagechapterProvider();
  var novelPageChapter = Novelpagechapter().obs;
  late String bookId;

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
    fetchNovelPageChapter();
    fetchComments();
    fetchNovelPageBuku();
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
      // Handle error here
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
        print(response.body);
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
      // Handle error as needed
    }
  }

  void fetchComments() {
    List<String> fetchedComments = [
      'Great chapter!',
      'Can\'t wait for the next one!',
      'I loved this chapter!',
    ];

    comments.value = fetchedComments;
  }

  void addComment(String comment) {
    comments.add(comment);
  }

  void deleteComment(int index) {
    comments.removeAt(index);
  }
}
