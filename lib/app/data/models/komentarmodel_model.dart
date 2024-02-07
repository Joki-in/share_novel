class Komentarmodel {
  String? status;
  List<Komentar>? komentar;

  Komentarmodel({this.status, this.komentar});

  Komentarmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['komentar'] != null) {
      komentar = <Komentar>[];
      json['komentar'].forEach((v) {
        komentar?.add(Komentar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (komentar != null) {
      data['komentar'] = komentar?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Komentar {
  int? id;
  int? idBuku;
  int? idUser;
  String? komentar;
  String? createdAt;
  String? updatedAt;
  User? user;

  Komentar(
      {this.id,
      this.idBuku,
      this.idUser,
      this.komentar,
      this.createdAt,
      this.updatedAt,
      this.user});

  Komentar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBuku = json['id_buku'];
    idUser = json['id_user'];
    komentar = json['komentar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_buku'] = idBuku;
    data['id_user'] = idUser;
    data['komentar'] = komentar;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? alamat;
  dynamic foto;
  dynamic otp;
  dynamic fcmToken;
  dynamic createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.alamat,
      this.foto,
      this.otp,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    alamat = json['alamat'];
    foto = json['foto'];
    otp = json['otp'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['alamat'] = alamat;
    data['foto'] = foto;
    data['otp'] = otp;
    data['fcm_token'] = fcmToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
