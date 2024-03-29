class Api {
  static const String baseUrl = 'http://sharenovel.wdmif.id/';
  static const String api = '${baseUrl}api/';
  //auth api
  static const String login = '${api}login';
  static const String register = '${api}register';
  static const String forgotPassword = '${api}forgot-password';
  static const String otp = '${api}check-otp';
  static const String resetPassword = '${api}reset-password';
  static const String logout = '${api}logout';

  //profile api
  static const String profile = '${api}profile';
  static const String updateProfile = '${api}update-profile';
  static const String updateFotoProfile = '${api}update-fotoprofile';
  static const String fotoprofile = '${baseUrl}fotouser/';

  //dashboard api
  static const String topLike = '${api}top-like';
  static const String topView = '${api}top-view';

  //search api
  static const String search = '${api}search2';

  //cover image Api
  static const String coverImage = '${baseUrl}coverbuku/';

  //novel api
  static const String novelPageBuku = '${api}novelpagebuku';
  static const String novelPageChapter = '${api}novelpageisi';
  static const String novelPageKomentar = '${api}novelpagekomentar';

  //view and like push
  static const String pushView = '${api}tambah-view';
  static const String checklike = '${api}check-like';
  static const String pushLike = '${api}tambah-like';
  static const String pushUnlike = '${api}hapus-like';

  //komentar api
  static const String postKomentar = '${api}komentarpost';

  //isi api
  static const String isi = '${api}getisibuku';

  //tambah buku api
  static const String tambahNovelShow = '${api}createbukushow';
  static const String createNovel = '${api}createbuku';
  static const String updateNovel = '${api}updateBuku';
  static const String deleteNovel = '${api}deletebuku';

  //crud isi api
  static const String deleteIsi = '${api}delete-isi';
  static const String updateIsi = '${api}update-isi';
  static const String createIsi = '${api}create-isi';
  static const String updateCover = '${api}updatecover';

  //favorite
  static const String favorite = '${api}favoritebuku';
}
