import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/components/comment.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/novelpage_controller.dart';

class NovelpageView extends GetView<NovelpageController> {
  const NovelpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NovelpageController controller = Get.put(NovelpageController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            final novelPageBuku = controller.novelPageBuku.value;
            if (novelPageBuku.bukus != null &&
                novelPageBuku.bukus!.isNotEmpty) {
              return Text(
                novelPageBuku.bukus![0].judul ?? 'Unknown', // Null check here
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            } else {
              return const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.Primary,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Obx(
              () {
                return Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      color: ColorConstant.Abu,
                      child: controller.novelPageBuku.value.bukus != null &&
                              controller.novelPageBuku.value.bukus!.isNotEmpty
                          ? Image.network(
                              controller.novelPageBuku.value.bukus![0]?.cover ??
                                  '',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      color: Colors.white,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.novelPageBuku.value.bukus?[0]?.judul ??
                                'Unknown', // Null check here
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                                size: 20.0,
                                color: ColorConstant.Primary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                controller.novelPageBuku.value.totalLike
                                        ?.toString() ??
                                    '0',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: ColorConstant.Primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.visibility_outlined,
                                size: 20.0,
                                color: ColorConstant.Primary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                controller.novelPageBuku.value.bukus?[0]?.view
                                        ?.toString() ??
                                    '0', // Null check here
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: ColorConstant.Primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Penulis: ${controller.novelPageBuku.value.bukus?[0]?.penulis?.name ?? 'Unknown'}', // Null check here
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Genre : ${controller.novelPageBuku.value.bukus?[0].genre}" ??
                                'Unknown', // Null check here
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            controller.novelPageBuku.value.bukus?[0].sinopsis ??
                                '', // Null check here
                            textAlign: TextAlign
                                .center, // atau TextAlign.justify untuk rata kiri-kanan
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double
                                    .infinity, // Lebar header diubah menjadi maksimum
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                color: ColorConstant.Primary,
                                child: Text(
                                  'Cari Chapter Anda',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.chapters.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      height: 50.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.chapters[index],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      height: MediaQuery.of(context).size.height /
                          2, // Atur tinggi maksimum sesuai kebutuhan
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.comments.length,
                              itemBuilder: (context, index) {
                                return CommentWidget(
                                  comment: controller.comments[index],
                                  onDelete: () {
                                    controller.deleteComment(index);
                                  },
                                  userPhotoUrl: controller.novelPageBuku.value
                                          .bukus?[0]?.cover ??
                                      '', // Null check here
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                controller.addComment(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Add a comment',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    controller.addComment(
                                        controller.commentTextController.text);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Obx(
              () => Positioned(
                top: MediaQuery.of(context).size.height * .20,
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: controller.novelPageBuku.value.bukus != null &&
                          controller.novelPageBuku.value.bukus!.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .35,
                          width: MediaQuery.of(context).size.width - 40.0,
                          child: Image.network(
                            controller.novelPageBuku.value.bukus![0].cover ??
                                '',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .35,
                            width: MediaQuery.of(context).size.width - 40.0,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
