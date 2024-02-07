class Isi {
  bool? success;
  List<Data>? data;

  Isi({this.success, this.data});

  Isi.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? idBuku;
  String? chapter;
  String? isi;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.idBuku,
      this.chapter,
      this.isi,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBuku = json['id_buku'];
    chapter = json['chapter'];
    isi = json['isi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_buku'] = idBuku;
    data['chapter'] = chapter;
    data['isi'] = isi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
