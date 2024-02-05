import 'package:get/get.dart';

import '../controllers/novelpage_controller.dart';

class NovelpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NovelpageController>(
      () => NovelpageController(),
    );
  }
}
