import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pet_care_app/feature/personalization/view/setting/setting_screen.dart';

import '../feature/customer/view/home/home_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => const CustomerHomeScreen()),
    GetPage(name: '/home', page: () => const CustomerHomeScreen()),
    GetPage(name: '/setting', page: () => const SettingScreen()),
  ];
}