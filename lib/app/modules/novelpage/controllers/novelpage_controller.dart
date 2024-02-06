import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NovelpageController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  RxList<String> comments = <String>[].obs;
  final TextEditingController commentTextController = TextEditingController();
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
