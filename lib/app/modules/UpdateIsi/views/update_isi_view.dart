import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_isi_controller.dart';

class UpdateIsiView extends GetView<UpdateIsiController> {
  @override
  Widget build(BuildContext context) {
    final UpdateIsiController controller = Get.put(UpdateIsiController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateIsiView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller.chapterTextfieldController,
                focusNode: controller.focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Nama Chapter',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0), // Sesuaikan padding di sini
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.isiTextfieldController,
                focusNode: controller.focusNode2,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Tulis Isi Novel Disini',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0), // Sesuaikan padding di sini
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.check == '1') {
                    controller.createIsi(
                        controller.chapterTextfieldController.text,
                        controller.isiTextfieldController.text);
                  } else {
                    controller.editIsi(
                        controller.chapterTextfieldController.text,
                        controller.isiTextfieldController.text);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
