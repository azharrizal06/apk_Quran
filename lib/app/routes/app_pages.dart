import 'package:get/get.dart';

import 'package:login2/app/modules/detail/bindings/detail_binding.dart';
import 'package:login2/app/modules/detail/views/detail_view.dart';
import 'package:login2/app/modules/detailjuz/bindings/detailjuz_binding.dart';
import 'package:login2/app/modules/detailjuz/views/detailjuz_view.dart';
import 'package:login2/app/modules/home/bindings/home_binding.dart';
import 'package:login2/app/modules/home/views/home_view.dart';
import 'package:login2/app/modules/intro/bindings/intro_binding.dart';
import 'package:login2/app/modules/intro/views/intro_view.dart';
import 'package:login2/app/modules/login/bindings/login_binding.dart';
import 'package:login2/app/modules/login/views/login_view.dart';
import 'package:login2/app/modules/regis/bindings/regis_binding.dart';
import 'package:login2/app/modules/regis/views/regis_view.dart';
import 'package:login2/app/modules/riset/bindings/riset_binding.dart';
import 'package:login2/app/modules/riset/views/riset_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGIS,
      page: () => RegisView(),
      binding: RegisBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.RISET,
      page: () => RisetView(),
      binding: RisetBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.DETAILJUZ,
      page: () => DetailjuzView(),
      binding: DetailjuzBinding(),
    ),
  ];
}
