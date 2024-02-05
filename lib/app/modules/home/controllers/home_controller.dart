import 'package:get/get.dart';
import 'package:share_novel/app/data/models/buku_model.dart';
import 'package:share_novel/app/data/provider/like_buku_provider.dart';
import 'package:share_novel/app/modules/home/controllers/top_view_controller_controller.dart';

class HomeController extends GetxController {
  final BukuProvider _bukuProvider = BukuProvider();
  final TopViewController controller = Get.put(TopViewController());

  final count = 0.obs;
  final bukuList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBukuTerbanyakLike();
    controller.fetchBukuTerbanyakView();
  }

  void relog() {
    fetchBukuTerbanyakLike();
    controller.fetchBukuTerbanyakView();
  }

  void fetchBukuTerbanyakLike() async {
    try {
      Buku buku = await _bukuProvider.getBukuTerbanyakLike();
      bukuList.assignAll(buku.data!);
    } catch (e) {
      print('Error: $e');
    }
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
