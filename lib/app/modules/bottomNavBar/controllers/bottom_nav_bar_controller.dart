import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/home/views/home_view.dart';
import 'package:share_novel/app/modules/login/views/login_view.dart';
import 'package:share_novel/app/modules/profile/views/profile_view.dart';
import 'package:share_novel/app/modules/tambahNovel/views/tambah_novel_view.dart';

class BottomNavBarController extends GetxController {
  //TODO: Implement BottomNavBarController
  var selectedIndex = 0.obs;
  final count = 0.obs;
  List<Widget> pages = [
    HomeView(), // Replace HomeView with your actual view/widget
    TambahNovelView(), // Replace SearchView with your actual view/widget
    ProfileView(), // Replace NotificationsView with your actual view/widget
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
