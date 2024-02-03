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
