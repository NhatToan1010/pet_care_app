import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ShadowStyle {

  static final lightShadow = BoxShadow(
    color: AppPallete.greyColor.withValues(alpha: 0.5),
    blurRadius: 5,
    spreadRadius: 7,
    offset: const Offset(0, 5)
  );

  static final darkShadow = BoxShadow(
      color: AppPallete.lightGrey.withAlpha(20),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}