// ignore_for_file: unrelated_type_equality_checks

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
                              controller.novelPageBuku.value.bukus![0].cover ??
                                  'data:image/png;base64,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',
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
                            controller.novelPageBuku.value.bukus?[0].judul ??
                                'Unknown', // Null check here
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          controller.novelPageBuku.value.bukus?[0].i18 == 1
                              ? Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: const Text(
                                    '18 ++',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (controller.statuslike == 'like') {
                                    try {
                                      await controller.unLike();
                                    } catch (e) {
                                      print('Failed to unlike: $e');
                                    }
                                  } else {
                                    try {
                                      await controller.createLike();
                                    } catch (e) {
                                      print('Failed to like: $e');
                                    }
                                  }
                                },
                                child: Obx(() {
                                  if (controller.statuslike == 'like') {
                                    return Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          size: 20.0,
                                          color: ColorConstant.Primary,
                                        ),
                                        const SizedBox(
                                            width:
                                                5), // Tambahkan jarak antara ikon dan teks
                                        Text(
                                          controller
                                                  .novelPageBuku.value.totalLike
                                                  ?.toString() ??
                                              '0',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: ColorConstant.Primary,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite_border,
                                          size: 20.0,
                                          color: ColorConstant.Primary,
                                        ),
                                        const SizedBox(
                                            width:
                                                5), // Tambahkan jarak antara ikon dan teks
                                        Text(
                                          controller
                                                  .novelPageBuku.value.totalLike
                                                  ?.toString() ??
                                              '0',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: ColorConstant.Primary,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                              ),
                              const SizedBox(width: 10),
                              Obx(() {
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.visibility_outlined,
                                      size: 20.0,
                                      color: ColorConstant.Primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.novelPageBuku.value.bukus?[0]
                                              .view
                                              ?.toString() ??
                                          '0',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: ColorConstant.Primary,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Penulis: ${controller.novelPageBuku.value.bukus?[0].penulis?.name ?? 'Unknown'}', // Null check here
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Genre : ${controller.novelPageBuku.value.bukus?[0].genre}", // Null check here
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.novelPageBuku.value.bukus?[0].sinopsis ??
                                '', // Null check here
                            textAlign: TextAlign
                                .center, // atau TextAlign.justify untuk rata kiri-kanan
                            style: const TextStyle(
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                color: ColorConstant.Primary,
                                child: const Text(
                                  'Cari Chapter Anda',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller
                                      .novelPageChapter.value.isi?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final chapter = controller
                                        .novelPageChapter.value.isi?[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          '/isinovel',
                                          arguments: {
                                            'idChapter': chapter?.id,
                                          },
                                        );
                                      },
                                      child: Container(
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
                                              Flexible(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 12.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      text: chapter?.chapter ??
                                                          'Unknown Chapter'),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height /
                          2, // Atur tinggi maksimum sesuai kebutuhan
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                            child: Obx(() => ListView.builder(
                                  itemCount: controller.komentarList.length,
                                  itemBuilder: (context, index) {
                                    final comment =
                                        controller.komentarList[index];
                                    final userPhotoUrl = comment.user?.foto ??
                                        'https://cdn.icon-icons.com/icons2/3708/PNG/512/man_person_people_avatar_icon_230017.png';
                                    return CommentWidget(
                                      userPhotoUrl: userPhotoUrl,
                                      comment:
                                          comment.komentar ?? 'Unknown comment',
                                    );
                                  },
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.commentTextController,
                              onFieldSubmitted: (value) {},
                              decoration: InputDecoration(
                                hintText: 'Add a comment',
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () async {
                                    await controller.postKomentar();
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                                'data:image/png;base64,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',
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
