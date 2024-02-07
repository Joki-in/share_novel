class Novelpagebuku {
  String? status;
  List<Bukus>? bukus;
  int? totalLike;

  Novelpagebuku({this.status, this.bukus, this.totalLike});

  Novelpagebuku.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['bukus'] != null) {
      bukus = <Bukus>[];
      json['bukus'].forEach((v) {
        bukus?.add(Bukus.fromJson(v));
      });
    }
    totalLike = json['total_like'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (bukus != null) {
      data['bukus'] = bukus?.map((v) => v.toJson()).toList();
    }
    data['total_like'] = totalLike;
    return data;
  }
}

class Bukus {
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
  int? totalLike;
  Penulis? penulis;

  Bukus(
      {this.id,
      this.judul,
      this.sinopsis,
      this.view,
      this.genre,
      this.cover,
      this.i18,
      this.penulisId,
      this.createdAt,
      this.updatedAt,
      this.totalLike,
      this.penulis});

  Bukus.fromJson(Map<String, dynamic> json) {
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
    totalLike = json['total_like'];
    penulis =
        json['penulis'] != null ? Penulis?.fromJson(json['penulis']) : null;
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
    data['total_like'] = totalLike;
    if (penulis != null) {
      data['penulis'] = penulis?.toJson();
    }
    return data;
  }
}

class Penulis {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? alamat;
  dynamic foto;
  dynamic otp;
  dynamic fcmToken;
  dynamic createdAt;
  dynamic updatedAt;

  Penulis(
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

  Penulis.fromJson(Map<String, dynamic> json) {
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
