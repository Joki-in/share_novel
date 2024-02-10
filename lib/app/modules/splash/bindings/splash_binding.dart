import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Get.Put<SplashController>(
    //   () => SplashController(),
    // );
    Get.put(SplashController());
  }
}
