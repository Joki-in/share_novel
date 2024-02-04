import 'package:get/get.dart';

import 'package:share_novel/app/modules/home/controllers/top_view_controller_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopViewController>(
      () => TopViewController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
