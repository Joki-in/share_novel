import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                    buku.cover ??
                                        'data:image/png;base64,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',
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
