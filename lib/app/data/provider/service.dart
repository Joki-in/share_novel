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

  //novel api
  static const String novelPageBuku = '${api}novelpagebuku';
  static const String novelPageChapter = '${api}novelpageisi';

  //view and like push
  static const String pushView = '${api}tambah-view';
}
