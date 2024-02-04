import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:share_novel/app/data/models/buku_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class BukuProvider extends GetConnect {
  Future<Buku> getBukuTerbanyakLike() async {
    var response = await get(Api.topLike);

    if (response.status.hasError) {
      print('Error: ${response.statusText}');
      return Future.error(response.statusText!);
    } else {
      // print('Response: ${response.bodyString}');
      return Buku.fromJson(response.body);
    }
  }
}
