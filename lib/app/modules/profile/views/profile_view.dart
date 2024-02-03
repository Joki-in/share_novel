import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.user.value != null
            ? RefreshIndicator(
                onRefresh: () => controller.fetchUser(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
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
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.white),
                                      onPressed: () {
                                        controller.pickImage();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //textfield and style
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 25, top: 10),
                              child: Obx(
                                () => TextField(
                                  style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                                  ),
                                  controller: controller.emailController
                                    ..text = controller.user.value?.email ?? '',
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Icon(Icons.email,
                                          size: 20), // Ubah ukuran ikon di sini
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.Primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 25, top: 10),
                              child: Obx(
                                () => TextField(
                                  style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                                  ),
                                  controller: controller.nameController
                                    ..text = controller.user.value?.name ?? '',
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Icon(Icons.person,
                                          size: 20), // Ubah ukuran ikon di sini
                                    ),
                                    hintText: 'Enter your name',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.Primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 25, top: 10),
                              child: Obx(
                                () => TextField(
                                  style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                                  ),
                                  controller: controller.alamatController
                                    ..text =
                                        controller.user.value?.alamat ?? '',
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Icon(Icons.location_on,
                                          size: 20), // Ubah ukuran ikon di sini
                                    ),
                                    hintText: 'Enter your Alamat',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.DarkPrimary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: ColorConstant.Primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: ColorConstant.Primary,
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                onPressed: () {
                                  controller.updateProfile();
                                },
                                child: const Text(
                                  "Simpan",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
