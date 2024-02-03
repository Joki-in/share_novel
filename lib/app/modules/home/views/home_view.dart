import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/modules/components/slider.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.Primary,
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Lottie.asset(
                  'assets/booklogin.json', // Ganti dengan path file JSON Lottie Anda
                  height: 40, // Sesuaikan tinggi gambar sesuai kebutuhan
                  width: 40, // Sesuaikan lebar gambar sesuai kebutuhan
                ),
                const SizedBox(width: 10),
                const Text(
                  'Share Novels',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.DarkPrimary,
                    fontSize: 20.0,
                    fontFamily: 'Roboto', // Menggunakan font Roboto
                    fontWeight:
                        FontWeight.bold, // Bisa disesuaikan sesuai kebutuhan
                    // Jika ingin menyesuaikan warna font, tambahkan properti color
                    // color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SliderWidget(),
            ],
          ),
        ));
  }
}
