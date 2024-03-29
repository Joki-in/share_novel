import 'package:get/get.dart';

import '../modules/UpdateIsi/bindings/update_isi_binding.dart';
import '../modules/UpdateIsi/views/update_isi_view.dart';
import '../modules/bottomNavBar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import '../modules/favorite_page/bindings/favorite_page_binding.dart';
import '../modules/favorite_page/views/favorite_page_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/isicreateshow/bindings/isicreateshow_binding.dart';
import '../modules/isicreateshow/views/isicreateshow_view.dart';
import '../modules/isinovel/bindings/isinovel_binding.dart';
import '../modules/isinovel/views/isinovel_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/novelpage/bindings/novelpage_binding.dart';
import '../modules/novelpage/views/novelpage_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/otp_register/bindings/otp_register_binding.dart';
import '../modules/otp_register/views/otp_register_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/searchPage/bindings/search_page_binding.dart';
import '../modules/searchPage/views/search_page_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tambahNovel/bindings/tambah_novel_binding.dart';
import '../modules/tambahNovel/views/tambah_novel_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_NOVEL,
      page: () => const TambahNovelView(),
      binding: TambahNovelBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => const SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.NOVELPAGE,
      page: () => const NovelpageView(),
      binding: NovelpageBinding(),
    ),
    GetPage(
      name: _Paths.ISINOVEL,
      page: () => const IsinovelView(),
      binding: IsinovelBinding(),
    ),
    GetPage(
      name: _Paths.ISICREATESHOW,
      page: () => const IsicreateshowView(),
      binding: IsicreateshowBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_ISI,
      page: () => UpdateIsiView(),
      binding: UpdateIsiBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE_PAGE,
      page: () => const FavoritePageView(),
      binding: FavoritePageBinding(),
    ),
    GetPage(
      name: _Paths.OTP_REGISTER,
      page: () => const OtpRegisterView(),
      binding: OtpRegisterBinding(),
    ),
  ];
}
