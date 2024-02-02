class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? alamat;
  String? foto;
  dynamic otp;
  dynamic fcmToken;
  String? createdAt;
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
