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
                                      '${Api.coverImage}${novel.dATA![index].cover ?? 'notfound.jpg'}',
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
                                    onPressed: () {
                                      Get.offAllNamed('/isicreateshow',
                                          arguments:
                                              novel.dATA![index].id ?? 0);
                                    },
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Anda Belum Menambahkan Buku"),
                        ],
                      ),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Tambah Buku',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: TextField(
                                      controller:
                                          controller.judulTextfieldController,
                                      focusNode: FocusNode(),
                                      maxLength: controller.maxLengthjudul,
                                      decoration: const InputDecoration(
                                        hintText: 'Judul',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller:
                                  controller.sinopsisTextfieldController,
                              focusNode: FocusNode(),
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              maxLength: 3000,
                              decoration: const InputDecoration(
                                hintText: 'Sinopsis',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "18 ++",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Obx(
                                  () {
                                    return Switch(
                                      value: controller.i18.value == 1,
                                      onChanged: (value) {
                                        controller.i18.value = value ? 1 : 0;
                                        print(controller.i18.value);
                                      },
                                      activeColor: Colors.red,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: Obx(() {
                                return DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Select an item',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 14.0,
                                    ),
                                  ),
                                  value:
                                      controller.selectedValue.value.isNotEmpty
                                          ? controller.selectedValue.value
                                          : null,
                                  onChanged: (value) {
                                    controller
                                        .setSelectedValue(value.toString());
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                  ),
                                  dropdownColor: Colors.white,
                                  elevation: 3,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(
                                      value: '',
                                      child: Text('Pilih Genre'),
                                    ),
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
                                  ],
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.storeBuku();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  "Submit Perubahan",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: ColorConstant.Primary,
          ),
        );
      }),
    );
  }
}
