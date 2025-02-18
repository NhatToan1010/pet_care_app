import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_care_app/feature/authentication/views/onboarding/onboarding_screen.dart';
import 'package:pet_care_app/feature/customer/customer_navigation_menu.dart';
import 'package:pet_care_app/feature/employee/view/employee_home.dart';
import 'package:pet_care_app/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: LocalTheme.lightTheme,
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}