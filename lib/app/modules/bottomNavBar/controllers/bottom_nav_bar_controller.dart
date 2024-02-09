import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/home/views/home_view.dart';
import 'package:share_novel/app/modules/profile/views/profile_view.dart';
import 'package:share_novel/app/modules/searchPage/views/search_page_view.dart';
import 'package:share_novel/app/modules/tambahNovel/views/tambah_novel_view.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  final count = 0.obs;
  List<Widget> pages = [
    const HomeView(),
    const SearchPageView(),
    const TambahNovelView(),
    const ProfileView(),
  ];
  @override
  void onInit() {
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

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
