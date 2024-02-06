import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NovelpageController extends GetxController {
  RxList<String> chapters = <String>[].obs;
  RxList<String> comments = <String>[].obs;
  final TextEditingController commentTextController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchChapters();
    fetchComments();
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
  void fetchChapters() {
    // Simulating fetching chapters from somewhere
    List<String> fetchedChapters = [
      'Chapter 1',
      'Chapter 2',
      'Chapter 3',
      'Chapter 4',
      'Chapter 5',
      'Chapter 6',
      'Chapter 7',
      'Chapter 8',
      'Chapter 9',
      'Chapter 10',
      'Chapter 11',
      'Chapter 12',
      'Chapter 13',
      'Chapter 14',
      'Chapter 15',
      'Chapter 16',
      'Chapter 17',
      'Chapter 18',
      'Chapter 19',
      'Chapter 20',
    ];

    chapters.value = fetchedChapters;
  }

  void fetchComments() {
    // Simulating fetching comments from somewhere
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
