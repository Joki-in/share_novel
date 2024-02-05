import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/search_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class SearchProvider {
  Future<Search?> fetchSearchData() async {
    try {
      final response = await http.post(Uri.parse(Api.search));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('bodynya ${response.body}');
        return Search.fromJson(jsonData);
      } else {
        print('bodynya ${response.body}');
        throw Exception('Failed to load search data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching search data: $e');
      return null; // Return null if there's an error
    }
  }
}
