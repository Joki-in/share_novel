import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/components/shimer_search.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchPageController controller = Get.put(SearchPageController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search Novel',
        backgroundColor: ColorConstant.Primary,
        lottieAssetPath: 'assets/booklogin.json',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.reloadData();
        },
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const ShimmerLoadingSearch();
            } else {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.Abu,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: controller.searchInputController,
                              decoration: const InputDecoration.collapsed(
                                filled: true,
                                fillColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                hintText: "Search",
                              ),
                              onChanged: controller.onSearchInputChange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: 'Select an item',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 14.0),
                      ),
                      value: controller.selectedValue.value.isNotEmpty
                          ? controller.selectedValue.value
                          : null,
                      onChanged: (value) {
                        controller.setSelectedValue(value.toString());
                      },
                      icon: const Icon(Icons.arrow_drop_down,
                          color: ColorConstant.DarkPrimary),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: ColorConstant.DarkPrimary,
                      ),
                      dropdownColor: Colors.white,
                      elevation: 3,
                      isExpanded: true,
                      items: const [
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
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredResult.length,
                    itemBuilder: (context, index) {
                      final result = controller.filteredResult[index];
                      return InkWell(
                        onTap: () {
                          // Mengambil objek buku yang dipilih
                          final selectedBuku = controller.filteredResult[index];
                          // Navigasi ke halaman novel dengan mengirim objek buku sebagai argumen
                          Get.toNamed('/novelpage', arguments: selectedBuku.id);
                        },
                        child: Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  result.cover ??
                                      "data:image/png;base64,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",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  result.judul ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
