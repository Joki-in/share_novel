import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/buku_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class ViewBukuProvider with ChangeNotifier {
  List<Buku>? _listBuku;

  List<Buku>? get listBuku => _listBuku;

  set listBuku(List<Buku>? newList) {
    _listBuku = newList;
    notifyListeners();
  }

  Future<void> fetchDataFromApi() async {
    final url = Uri.parse(Api.topView);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _listBuku = (jsonData['data'] as List)
            .map((item) => Buku.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
