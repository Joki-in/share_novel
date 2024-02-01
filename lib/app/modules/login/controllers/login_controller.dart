import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var obscureText = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
