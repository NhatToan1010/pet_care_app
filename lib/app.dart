import 'package:flutter/material.dart';
import 'package:pet_care_app/feature/authentication/views/onboarding/onboarding_screen.dart';
import 'package:pet_care_app/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: LocalTheme.lightTheme,
      home: OnboardingScreen(),
    );
  }
}