import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/provider/service.dart';

import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/components/slider.dart';
import 'package:share_novel/app/modules/home/controllers/home_controller.dart';
import 'package:share_novel/app/modules/home/controllers/top_view_controller_controller.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TopViewController topController = Get.put(TopViewController());
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Share Novels',
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          topController.fetchBukuTerbanyakView();
          homeController.relog();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SliderWidget(),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Novel Terpopuler',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                final controller = topController;

                if (controller.bukuTerbanyakView.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 20),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final buku = controller.bukuTerbanyakView[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/novelpage', arguments: buku.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: [
                                  Image.network(
                                    '${Api.coverImage}${buku.cover ?? 'notfound.jpg'}',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Text(
                                              buku.judul ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '${buku.view ?? 0} view',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: controller.bukuTerbanyakView.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
