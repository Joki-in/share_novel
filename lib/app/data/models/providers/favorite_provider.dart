import 'package:get/get.dart';

import '../favorite_model.dart';

class FavoriteProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Favorite.fromJson(map);
      if (map is List)
        return map.map((item) => Favorite.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Favorite?> getFavorite(int id) async {
    final response = await get('favorite/$id');
    return response.body;
  }

  Future<Response<Favorite>> postFavorite(Favorite favorite) async =>
      await post('favorite', favorite);
  Future<Response> deleteFavorite(int id) async => await delete('favorite/$id');
}
