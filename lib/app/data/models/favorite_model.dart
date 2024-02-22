class Favorite {
  int? id;
  String? judul;
  String? sinopsis;
  int? view;
  String? genre;
  String? cover;
  int? i18;
  int? penulisId;
  String? createdAt;
  String? updatedAt;

  Favorite(
      {this.id,
      this.judul,
      this.sinopsis,
      this.view,
      this.genre,
      this.cover,
      this.i18,
      this.penulisId,
      this.createdAt,
      this.updatedAt});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    sinopsis = json['sinopsis'];
    view = json['view'];
    genre = json['genre'];
    cover = json['cover'];
    i18 = json['18+'];
    penulisId = json['penulis_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['sinopsis'] = sinopsis;
    data['view'] = view;
    data['genre'] = genre;
    data['cover'] = cover;
    data['18+'] = i18;
    data['penulis_id'] = penulisId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
