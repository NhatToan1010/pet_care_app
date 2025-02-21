import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_care_app/binding/general_binding.dart';
import 'package:pet_care_app/routes/app_route.dart';
import 'package:pet_care_app/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBinding(),
      title: 'Flutter Demo',
      getPages: AppRoutes.pages,
      theme: LocalTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
