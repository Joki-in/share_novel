import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/models/novelpagebuku_model.dart';
import 'package:share_novel/app/data/provider/novel_page_buku_provider.dart';

class NovelpageController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  RxList<String> comments = <String>[].obs;
  final TextEditingController commentTextController = TextEditingController();
  Rx<Novelpagebuku> novelPageBuku = Novelpagebuku().obs;
  final NovelPageBukuProvider novelPageBukuProvider = NovelPageBukuProvider();
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
    fetchChapters();
    fetchComments();
    fetchNovelPageBuku();
    print("Book ID: $bookId");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  void fetchChapters() {
    // Simulate fetching chapters from somewhere
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
