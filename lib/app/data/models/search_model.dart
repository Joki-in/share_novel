class Search {
  String? mESSAGE;
  List<DATA>? dATA;

  Search({this.mESSAGE, this.dATA});

  Search.fromJson(Map<String, dynamic> json) {
    mESSAGE = json['MESSAGE'];
    if (json['DATA'] != null) {
      dATA = <DATA>[];
      json['DATA'].forEach((v) {
        dATA?.add(DATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['MESSAGE'] = mESSAGE;
    if (dATA != null) {
      data['DATA'] = dATA?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATA {
  int? id;
  String? judul;
  String? sinopsis;
  int? like;
  int? view;
  String? cover;
  int? penulisId;
  String? createdAt;
  String? updatedAt;

  DATA(
      {this.id,
      this.judul,
      this.sinopsis,
      this.like,
      this.view,
      this.cover,
      this.penulisId,
      this.createdAt,
      this.updatedAt});

  DATA.fromJson(Map<String, dynamic> json) {
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
    final data = <String, dynamic>{};
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
