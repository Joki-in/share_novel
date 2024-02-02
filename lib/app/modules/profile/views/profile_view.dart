import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_novel/app/data/provider/service.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Obx(
                  () {
                    if (controller.user.value != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.blue,
                                      width:
                                          2.0), // Atur warna dan lebar pinggiran di sini
                                ),
                                child: ClipOval(
                                  child: controller.user.value!.foto != null
                                      ? Image.network(
                                          Api.fotoprofile +
                                              controller.user.value!.foto
                                                  .toString(),
                                          width: 150.0,
                                          height: 150.0,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            // Jika terjadi kesalahan dalam memuat gambar, kembalikan gambar dari asset
                                            return Image.asset(
                                              'assets/person.png',
                                              width: 130.0,
                                              height: 130.0,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/person.png',
                                          width: 150.0,
                                          height: 150.0,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .blue, // Ubah warna latar belakang tombol menjadi biru
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors
                                            .white), // Ubah warna ikon tombol menjadi putih
                                    onPressed: () {
                                      // Fungsi untuk menangani ketika tombol edit ditekan
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text('ID: ${controller.user.value!.id}'),
                          Text('Name: ${controller.user.value!.name}'),
                          Text('Email: ${controller.user.value!.email}'),
                          // tambahkan widget lainnya sesuai kebutuhan
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
