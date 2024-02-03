import 'package:get/get.dart';
import 'package:share_novel/app/data/models/buku_model.dart';
import 'package:share_novel/app/data/provider/like_buku_provider.dart';
import 'package:share_novel/app/data/provider/view_buku_provider.dart';

class HomeController extends GetxController {
  final BukuProvider _bukuProvider = BukuProvider();
  final ViewBukuProvider _viewBukuProvider = ViewBukuProvider();

  final count = 0.obs;
  final bukuList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBukuTerbanyakLike();
    fetchBukuView();
  }

  void fetchBukuTerbanyakLike() async {
    try {
      Buku buku = await _bukuProvider.getBukuTerbanyakLike();
      bukuList.assignAll(buku.data!);
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchBukuView() async {
    try {
      await _viewBukuProvider.fetchDataFromApi();
      final List<Data>? dataBuku = _viewBukuProvider.listBuku?.cast<Data>();
      bukuList.assignAll(dataBuku ?? []);
    } catch (e) {
      print('Error fetching data from API: $e');
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
