import 'package:get/get.dart';

import '../controllers/isinovel_controller.dart';

class IsinovelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IsinovelController>(
      () => IsinovelController(),
    );
  }
}
