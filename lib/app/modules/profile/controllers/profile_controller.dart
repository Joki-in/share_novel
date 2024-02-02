import 'package:get/get.dart';
import 'package:share_novel/app/data/models/user_model.dart';
import 'package:share_novel/app/data/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final UserProvider _userProvider = Get.put(UserProvider());

  Rx<User?> get user => _userProvider.user;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
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
  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await _userProvider.fetchUser(token);
      } else {
        print('Token is null');
      }
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }
}
