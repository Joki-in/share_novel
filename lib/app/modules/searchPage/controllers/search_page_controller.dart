import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/search_buku_provider.dart';

class SearchPageController extends GetxController {
  var searchResult = <DATA>[].obs;
  var filteredResult = <DATA>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedValue = ''.obs;

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
        filteredResult.assignAll(searchResult);
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
    if (query.isEmpty && selectedValue.isEmpty) {
      filteredResult.assignAll(searchResult);
    } else {
      filteredResult.assignAll(searchResult.where((result) {
        final isQueryMatch =
            result.judul!.toLowerCase().contains(query.toLowerCase());
        final isGenreMatch = selectedValue.isEmpty ||
            result.genre!.toLowerCase() == selectedValue.toLowerCase();
        return isQueryMatch && isGenreMatch;
      }));
    }
  }

  void onSearchInputChange(String query) {
    filterSearchResults(query);
    update();
  }

  void setSelectedValue(String value) {
    selectedValue.value = value;
    filterSearchResults(searchInputController.text);
    update();
  }

  Future<void> reloadData() async {
    try {
      isLoading(true);
      final searchProvider = SearchProvider();
      final searchData = await searchProvider.fetchSearchData();
      if (searchData != null && searchData.dATA != null) {
        searchResult.assignAll(searchData.dATA!);
        filteredResult.assignAll(searchResult);
      } else {
        errorMessage('No data available');
      }
    } catch (e) {
      errorMessage('Error fetching search data: $e');
    } finally {
      isLoading(false);
    }
  }
}
