class Buku {
  String? status;
  List<Data>? data;

  Buku({this.status, this.data});

  Buku.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? judul;
  String? sinopsis;
  int? view;
  String? genre;
  String? cover;
  int? penulisId;
  int? likeCount;

  Data(
      {this.id,
      this.judul,
      this.sinopsis,
      this.view,
      this.genre,
      this.cover,
      this.penulisId,
      this.likeCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    sinopsis = json['sinopsis'];
    view = json['view'];
    genre = json['genre'];
    cover = json['cover'];
    penulisId = json['penulis_id'];
    likeCount = json['like_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['sinopsis'] = sinopsis;
    data['view'] = view;
    data['genre'] = genre;
    data['cover'] = cover;
    data['penulis_id'] = penulisId;
    data['like_count'] = likeCount;
    return data;
  }
}
