import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/tambah_novel_controller.dart';

class TambahNovelView extends GetView<TambahNovelController> {
  const TambahNovelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tambah Novel',
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextFormField(
          maxLines: null, // Teks akan tumbuh sesuai kebutuhan
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: 'Write your long text here',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
