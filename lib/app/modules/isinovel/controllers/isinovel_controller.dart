import 'package:get/get.dart';

class IsinovelController extends GetxController {
  //TODO: Implement IsinovelController

  final count = 0.obs;
  var idChapter; // variabel untuk menyimpan idChapter

  @override
  void onInit() {
    super.onInit();
    idChapter = Get.arguments['idChapter'];
    print(idChapter);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
