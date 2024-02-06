class Novelpagechapter {
  String? status;
  List<Isi>? isi;

  Novelpagechapter({this.status, this.isi});

  Novelpagechapter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['isi'] != null) {
      isi = <Isi>[];
      json['isi'].forEach((v) {
        isi?.add(Isi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (isi != null) {
      data['isi'] = isi?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Isi {
  int? id;
  int? idBuku;
  String? chapter;
  String? isi;
  String? createdAt;
  String? updatedAt;

  Isi(
      {this.id,
      this.idBuku,
      this.chapter,
      this.isi,
      this.createdAt,
      this.updatedAt});

  Isi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBuku = json['id_buku'];
    chapter = json['chapter'];
    isi = json['isi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_buku'] = idBuku;
    data['chapter'] = chapter;
    data['isi'] = isi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
