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
    final Map<String, dynamic> data = {};
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
  int? like;
  int? view;
  String? cover;
  int? penulisId;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.judul,
    this.sinopsis,
    this.like,
    this.view,
    this.cover,
    this.penulisId,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    sinopsis = json['sinopsis'];
    like = json['like'];
    view = json['view'];
    cover = json['cover'];
    penulisId = json['penulis_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['judul'] = judul;
    data['sinopsis'] = sinopsis;
    data['like'] = like;
    data['view'] = view;
    data['cover'] = cover;
    data['penulis_id'] = penulisId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
