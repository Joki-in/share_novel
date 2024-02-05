import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/search_buku_provider.dart';

class SearchPageController extends GetxController {
  var searchResult = <DATA>[].obs;
  var filteredResult =
      <DATA>[].obs; // Tambahkan variabel untuk hasil yang sudah difilter
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final searchInputController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchSearchData();
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
  Future<void> fetchSearchData() async {
    try {
      isLoading(true);
      final searchProvider = SearchProvider();
      final searchData = await searchProvider.fetchSearchData();
      if (searchData != null && searchData.dATA != null) {
        searchResult.assignAll(searchData.dATA!);
        filteredResult
            .assignAll(searchResult); // Mengisi filteredResult dengan data awal
      } else {
        errorMessage('No data available');
      }
    } catch (e) {
      errorMessage('Error fetching search data: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua data
      filteredResult.assignAll(searchResult);
    } else {
      // Jika query tidak kosong, filter data berdasarkan query
      filteredResult.assignAll(searchResult.where((result) =>
          result.judul!.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void onSearchInputChange(String query) {
    filterSearchResults(query);
    update(); // Refresh tampilan setelah data difilter
  }
}
