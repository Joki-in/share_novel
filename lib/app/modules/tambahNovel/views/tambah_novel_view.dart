import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_novel_controller.dart';

class TambahNovelView extends GetView<TambahNovelController> {
  const TambahNovelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TambahNovelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahNovelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
