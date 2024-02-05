import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
import 'package:share_novel/app/modules/components/shimer_search.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';
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
        child: Obx(() {
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
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        // Action when grid item is tapped
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
                                result.cover ?? "",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 4,
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
        }),
      ),
    );
  }
}
