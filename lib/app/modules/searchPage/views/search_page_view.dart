import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/components/appbar.dart';
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
      body: ListView(
        padding: EdgeInsets.zero, // Menghilangkan jarak paling bawah
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
          Obx(
            () => GridView.builder(
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
          ),
        ],
      ),
    );
  }
}
