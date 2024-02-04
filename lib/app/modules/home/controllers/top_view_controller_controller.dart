import 'package:get/get.dart';
import 'package:share_novel/app/data/models/view_model.dart'; // Pastikan mengimpor model dari view_model.dart
import 'package:share_novel/app/data/provider/view_buku_provider.dart';
import 'package:share_novel/app/modules/home/controllers/home_controller.dart';

class TopViewController extends GetxController {
  final _bukuTerbanyakView = RxList<Data>(); // Change to RxList<Data>
  RxList<Data> get bukuTerbanyakView => _bukuTerbanyakView;

  final isLoading = true.obs;

  @override
  void onInit() {
    fetchBukuTerbanyakView(); // Panggil method fetchBukuTerbanyakView di onInit
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

  void fetchBukuTerbanyakView() async {
    try {
      var view = await ViewBukuProvider().getBukuTerbanyakView();
      if (view != null && view.data != null && view.data!.isNotEmpty) {
        _bukuTerbanyakView
            .assignAll(view.data!); // Menggunakan assignAll untuk mengisi data
      }
      isLoading.value = false;
      // _bukuTerbanyakView.forEach((buku) {
      //   print(buku.judul);
      // });
    } catch (e) {
      print('Error: $e');
      isLoading.value = false; // Set isLoading menjadi false jika terjadi error
    }
  }
}
