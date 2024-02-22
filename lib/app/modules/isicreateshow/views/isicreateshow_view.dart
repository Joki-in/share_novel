import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/components/shimmer_chaptershow.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/isicreateshow_controller.dart';

class IsicreateshowView extends GetView<IsicreateshowController> {
  const IsicreateshowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAllNamed('/bottom-nav-bar');
              },
            ),
            const SizedBox(width: 10),
            Lottie.asset(
              'assets/booklogin.json',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              "Share Novel",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstant.DarkPrimary,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.Primary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(
            '/update-isi',
            arguments: {
              'id_buku': controller.bookId,
            },
          );
        },
        label: Text(
            'Tambah Chapter'), // Teks yang ingin ditambahkan di sebelah ikon
        icon: Icon(Icons.add), // Ikon yang ingin ditampilkan
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      final bukus = controller.novelPageBuku.value.bukus;
                      return Stack(
                        children: [
                          bukus != null && bukus.isNotEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    '${Api.coverImage}${bukus[0].cover ?? 'notfound.jpg'}',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    color: Colors.white,
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12)),
                                ),
                                child:
                                    Icon(Icons.camera_alt, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Judul",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Obx(() {
                return TextField(
                  controller: controller.judulTextfieldController,
                  onChanged: (value) => controller.judul.value = value,
                  focusNode: FocusNode(),
                  maxLength: 75,
                  decoration: const InputDecoration(
                    hintText: 'Judul',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              const Text(
                "Sinopsis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Obx(() {
                return TextField(
                  controller: controller.sinopsisTextfieldController,
                  onChanged: (value) => controller.sinopsis.value = value,
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  maxLength: 3000,
                  decoration: const InputDecoration(
                    hintText: 'Sinopsis',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 16.0), // Sesuaikan padding di sini
                  ),
                );
              }),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "18 ++",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() {
                    return Switch(
                      value: controller.i18.value == 1,
                      onChanged: (value) {
                        // Jika Switch diaktifkan, set nilai i18 menjadi 1, jika tidak, set menjadi 0
                        controller.i18.value = value ? 1 : 0;
                        print(controller.i18.value);
                      },
                      activeColor: ColorConstant
                          .Danger, // Ubah warna ketika Switch aktif
                    );
                  }),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    20, // Sesuaikan lebar sesuai kebutuhan
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: 'Select an item',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 14.0),
                    ),
                    value: controller.selectedValue.value.isNotEmpty
                        ? controller.selectedValue.value
                        : null,
                    onChanged: (value) {
                      controller.setSelectedValue(value.toString());
                    },
                    icon: const Icon(Icons.arrow_drop_down,
                        color: ColorConstant.DarkPrimary),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: ColorConstant.DarkPrimary,
                    ),
                    dropdownColor: Colors.white,
                    elevation: 3,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'fiksi',
                        child: Text('Fiksi'),
                      ),
                      DropdownMenuItem(
                        value: 'drama',
                        child: Text('Drama'),
                      ),
                      DropdownMenuItem(
                        value: 'horor',
                        child: Text('Horor'),
                      ),
                      DropdownMenuItem(
                        value: 'komedi',
                        child: Text('Komedi'),
                      ),
                      DropdownMenuItem(
                        value: 'aksi',
                        child: Text('Aksi'),
                      ),
                      DropdownMenuItem(
                        value: 'romantis',
                        child: Text('Romatis'),
                      ),
                      DropdownMenuItem(
                        value: 'misteri',
                        child: Text('Misteri'),
                      ),
                      DropdownMenuItem(
                        value: 'kriminal',
                        child: Text('Kriminal'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateBuku();
                  },
                  child: Text(
                    "Submit Perubahan",
                    style: TextStyle(color: ColorConstant.WhiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.Primary),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      color: ColorConstant.Primary,
                      child: const Text(
                        'Cari Chapter Anda',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Obx(() {
                      if (controller.novelPageChapter.value.isi == null) {
                        return const ShimmerChapter();
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount:
                                controller.novelPageChapter.value.isi?.length,
                            itemBuilder: (BuildContext context, int index) {
                              final chapter =
                                  controller.novelPageChapter.value.isi?[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              const StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            text: chapter?.chapter ??
                                                'Unknown Chapter',
                                          ),
                                        ),
                                      ),
                                      const Spacer(flex: 1),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: ColorConstant.Alert,
                                        iconSize: 24.0,
                                        onPressed: () {
                                          Get.toNamed('/update-isi',
                                              arguments: {
                                                'id': chapter?.id ?? '',
                                                'chapter':
                                                    chapter?.chapter ?? '',
                                                'isi': chapter?.isi ?? '',
                                                'id_buku': chapter?.idBuku ?? 0,
                                              });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: ColorConstant.Danger,
                                        iconSize: 24.0,
                                        onPressed: () {
                                          controller.deleteIsiById(
                                              chapter?.id?.toString() ?? '0');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
