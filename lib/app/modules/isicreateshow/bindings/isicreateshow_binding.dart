import 'package:get/get.dart';

import '../controllers/isicreateshow_controller.dart';

class IsicreateshowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IsicreateshowController>(
      () => IsicreateshowController(),
    );
  }
}
