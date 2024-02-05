// Import yang diperlukan
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_novel/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

// Widget SliderWidget
class SliderWidget extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_homeController.bukuList.isEmpty &&
            _homeController.count.value == 0) {
          return _buildShimmerEffect();
        } else if (_homeController.bukuList.isEmpty &&
            _homeController.count.value > 0) {
          return const Text("Failed to fetch data!");
        } else {
          return SizedBox(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Like Terbanyak",
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    // Tambahkan ClipRRect di sini
                    borderRadius: BorderRadius.circular(
                        15.0), // atur border radius sesuai keinginan
                    child: CustomCarouselSlider(
                      items: List.generate(
                        3,
                        (index) {
                          final buku = _homeController.bukuList[
                              index % _homeController.bukuList.length];
                          return CarouselItem(
                            image: NetworkImage(buku.cover ?? ''),
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: buku.judul ?? '',
                            titleTextStyle: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            leftSubtitle: "Like ${buku.likeCount}",
                            leftSubtitleTextStyle: GoogleFonts.prostoOne(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            onImageTap: (i) {},
                          );
                        },
                      ),
                      height: 250,
                      subHeight: 70,
                      width: MediaQuery.of(context).size.width,
                      autoplay: true,
                      showSubBackground: true,
                      showText: true,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildShimmerEffect() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 200,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              // Tambahkan ClipRRect di sini
              borderRadius: BorderRadius.circular(
                  15.0), // atur border radius sesuai keinginan
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 320,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
