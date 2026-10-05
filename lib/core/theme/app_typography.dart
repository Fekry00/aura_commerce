import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get displayHero => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 38 / 32,
        letterSpacing: -0.025 * 32,
        color: AppColors.slateHeadline,
      );

  static TextStyle get headlineLg => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 30 / 24,
        letterSpacing: -0.02 * 24,
        color: AppColors.slateHeadline,
      );

  static TextStyle get headlineMd => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 26 / 20,
        letterSpacing: -0.015 * 20,
        color: AppColors.slateHeadline,
      );

  static TextStyle get priceHero => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 28 / 24,
        letterSpacing: -0.02 * 24,
        color: AppColors.primaryContainer,
      );

  static TextStyle get priceCatalog => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 20 / 16,
        letterSpacing: -0.01 * 16,
        color: AppColors.onSurface,
      );

  static TextStyle get bodyMd => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: -0.005 * 14,
        color: AppColors.slateBody,
      );

  static TextStyle get labelCaps => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 14 / 11,
        letterSpacing: 0.08 * 11,
        color: AppColors.slateBody,
      );
}

class AppSpacing {
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 40.0;
  static const double margin = 20.0;
}