import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/view/screens/home_page.dart';
import 'package:body_tech_app/view/screens/login_page.dart';
import 'package:body_tech_app/view/screens/register_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.register, page: () => RegisterPage()),
    GetPage(name: AppRoutes.home, page: () => HomePage()),
  ];
}
