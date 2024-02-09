import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/components/shimmer_chaptershow.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/isicreateshow_controller.dart';

class IsicreateshowView extends GetView<IsicreateshowController> {
  const IsicreateshowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IsicreateshowController controller =
        Get.put(IsicreateshowController());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
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
            Text(
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(
            '/update-isi',
            arguments: {
              'id_buku': controller.bookId,
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                                'id_buku': chapter?.idBuku ??
                                                    0, // Atau berikan nilai default yang sesuai
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
            ),
          ],
        ),
      ),
    );
  }
}
