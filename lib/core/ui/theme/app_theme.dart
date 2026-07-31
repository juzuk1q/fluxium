import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
    brightness: .dark,
    scaffoldBackgroundColor: AppColors.surfaceBackground,
    colorScheme: .dark(
      error: AppColors.error,
      // surface: AppColors.surfaceCard,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.header,
      bodyLarge: AppTextStyles.body15,
      bodyMedium: AppTextStyles.body14,
      bodySmall: AppTextStyles.body12,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceBackground,
      titleTextStyle: AppTextStyles.header,
    ),
  );
}