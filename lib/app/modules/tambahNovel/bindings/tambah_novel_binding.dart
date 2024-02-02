import 'package:get/get.dart';

import '../controllers/tambah_novel_controller.dart';

class TambahNovelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahNovelController>(
      () => TambahNovelController(),
    );
  }
}
