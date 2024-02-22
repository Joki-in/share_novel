import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/provider/service.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import '../controllers/favorite_page_controller.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

class FavoritePageView extends GetView<FavoritePageController> {
  const FavoritePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favorite Novels', // Sesuaikan judul AppBar
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchFavorite();
        },
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
                final novels =
                    controller.tambahNovelData.value; // Ubah nama variabel
                if (novels != null && novels.isNotEmpty) {
                  // Periksa apakah daftar novel tidak kosong
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
                        final novel = novels[
                            index]; // Dapatkan novel pada indeks tertentu
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/novelpage', arguments: novel.id);
                          },
                          child: Container(
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
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${Api.coverImage}${novel.cover ?? 'notfound.jpg'}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Expanded(
                                  child: Text(
                                    '${novel.judul}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: novels.length, // Gunakan panjang daftar novel
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                          "Anda Belum Menambahkan Buku"), // Ubah pesan jika tidak ada novel
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
