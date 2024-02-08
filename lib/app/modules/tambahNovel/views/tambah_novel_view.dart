import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/tambah_novel_controller.dart';

class TambahNovelView extends GetView<TambahNovelController> {
  const TambahNovelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TambahNovelController controller = Get.put(TambahNovelController());

    final ScrollController scrollController = ScrollController();

    // Variabel reaktif untuk mengontrol visibilitas FloatingActionButton
    final isFabVisible = true.obs;

    // Listener untuk memantau perubahan posisi gulir
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        isFabVisible.value = true;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isFabVisible.value = false;
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tambah Novel',
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchTambahNovelData,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: 10.0),
              sliver: SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: Obx(() {
                if (controller.tambahNovelValue != null) {
                  final novel = controller.tambahNovelValue!;
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${Api.coverImage}${novel.dATA![index].cover ?? 'https://via.placeholder.com/150'}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                child: Text(
                                  '${novel.dATA![index].judul}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    iconSize: 24.0,
                                    color: ColorConstant.Alert,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: ColorConstant.Danger,
                                    iconSize: 24.0,
                                    onPressed: () {
                                      final idBuku = novel.dATA![index].id!;
                                      controller.deleteDataByBukuId(idBuku);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: novel.dATA!.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        return Visibility(
          visible: isFabVisible.value,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: ColorConstant.Primary,
          ),
        );
      }),
    );
  }
}
