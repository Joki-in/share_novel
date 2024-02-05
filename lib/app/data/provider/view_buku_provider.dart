import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:share_novel/app/data/models/view_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class ViewBukuProvider {
  Future<ViewModel> getBukuTerbanyakView() async {
    Uri url = Uri.parse(Api.topView); // Mengonversi String menjadi Uri

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      // print('Response: ${response.body}');
      return ViewModel.fromJson(responseBody);
    } else {
      print('Error: ${response.reasonPhrase}');
      throw Exception('Failed to load Buku');
    }
  }
}
