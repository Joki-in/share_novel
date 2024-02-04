class ViewModel {
  String? status;
  List<Data>? data;

  ViewModel({this.status, this.data});

  ViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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

  Data(
      {this.id,
      this.judul,
      this.sinopsis,
      this.like,
      this.view,
      this.cover,
      this.penulisId,
      this.createdAt,
      this.updatedAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['sinopsis'] = this.sinopsis;
    data['like'] = this.like;
    data['view'] = this.view;
    data['cover'] = this.cover;
    data['penulis_id'] = this.penulisId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
