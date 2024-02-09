import 'package:get/get.dart';

import '../controllers/update_isi_controller.dart';

class UpdateIsiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateIsiController>(
      () => UpdateIsiController(),
    );
  }
}
