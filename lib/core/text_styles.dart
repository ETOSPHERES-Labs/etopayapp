// lib/core/text_styles.dart

import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static const boldCentered = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
