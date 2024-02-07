import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/isinovel/controllers/isinovel_controller.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

class IsinovelView extends GetView<IsinovelController> {
  const IsinovelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Share Novels',
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      floatingActionButton: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Mengatur jarak antara tombol
        children: [
          FloatingActionButton(
            onPressed: () async {
              await controller.stopSpeech();
            },
            backgroundColor: ColorConstant.Primary,
            child: const Icon(Icons.stop),
          ),
          FloatingActionButton(
            onPressed: () {
              controller.textToSpeech(controller.isi.value.data![0].isi!);
            },
            backgroundColor: ColorConstant.Primary,
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
          children: [
            SizedBox(height: 20),
            Obx(() {
              if (controller.isi.value.data != null) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to the left
                    children: [
                      Center(
                        child: Center(
                          child: Text(
                            '${controller.isi.value.data![0].chapter}',
                            textAlign: TextAlign.center, // Align to the left
                            style: GoogleFonts.openSans(
                              // Change font to Open Sans
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${controller.isi.value.data![0].isi}',
                        textAlign: TextAlign.left, // Align to the left
                        style: GoogleFonts.openSans(
                          // Change font to Open Sans
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (controller.isi.value.success == false) {
                return Text(
                  'Failed to fetch data',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
