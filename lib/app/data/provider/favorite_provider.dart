import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share_novel/app/data/models/favorite_model.dart';
import 'package:share_novel/app/data/provider/service.dart';

class FavoritePageProvider {
  Future<List<Favorite>?> fetchfavoriteshow(int idUser) async {
    try {
      final response = await http.post(
        Uri.parse(Api.favorite),
        body: {'id_user': idUser.toString()},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Favorite> favorites =
            jsonData.map((data) => Favorite.fromJson(data)).toList();
        return favorites;
      } else {
        print('bodynya ${response.body}');
        throw Exception('Failed to load favorite data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorite data: $e');
      return null;
    }
  }
}
