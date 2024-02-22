import 'package:get/get.dart';
import 'package:share_novel/app/data/models/favorite_model.dart';
import 'package:share_novel/app/data/provider/favorite_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePageController extends GetxController {
  //TODO: Implement FavoritePageController
  final FavoritePageProvider provider = FavoritePageProvider();
  final Rx<List<Favorite>?> tambahNovelData = Rx<List<Favorite>?>(null);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchFavorite();
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
  void fetchFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final idUserString = prefs.getString('user_id');
    final idUser = int.tryParse(idUserString ?? '') ?? 0;

    try {
      final result = await provider.fetchfavoriteshow(idUser);
      if (result != null) {
        tambahNovelData.value = result;
      } else {
        Get.snackbar('Error', 'Failed to load favorite data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching favorite data: $e');
    }
  }
}
