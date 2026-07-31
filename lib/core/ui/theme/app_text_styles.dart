import 'app_colors.dart';
import 'package:vize/vize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // Base styles
  static TextStyle _base({
      required double fontSize,
      required FontWeight fontWeight,
      Color? color,
      double? letterSpacing,
  }) => TextStyle(
    fontFamily: 'Nunito',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.contentPrimary,
    letterSpacing: letterSpacing,
  );

  static TextStyle _mono({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) => TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.contentPrimary,
  );

  // Header & Body textStyles
  static TextStyle get header => _base(fontSize: 32.ts, fontWeight: .w700);
  static TextStyle get body15 => _base(fontSize: 15.ts, fontWeight: .w400);
  static TextStyle get body14 => _base(fontSize: 14.ts, fontWeight: .w600);
  static TextStyle get body12 => _base(fontSize: 12.ts, fontWeight: .w400);
  static TextStyle get body11 => _base(fontSize: 11.ts, fontWeight: .w700);
  static TextStyle get body10 => _base(fontSize: 10.ts, fontWeight: .w400);
  static TextStyle get body9 => _base(fontSize: 9.ts, fontWeight: .w400);

  // Metrics
  static TextStyle get metricValue => _mono(fontSize: 26.ts, fontWeight: .w800);
  static TextStyle get metricUnit => _mono(fontSize: 12.ts, fontWeight: .w400);
  static TextStyle get metricIP => _mono(fontSize: 14.ts, fontWeight: .w500);
}
