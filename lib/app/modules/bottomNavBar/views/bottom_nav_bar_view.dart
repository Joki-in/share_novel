import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search Novel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Kelola Novel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          selectedItemColor: ColorConstant.DarkPrimary,
          unselectedItemColor: ColorConstant.Primary,
        ),
      ),
    );
  }
}
