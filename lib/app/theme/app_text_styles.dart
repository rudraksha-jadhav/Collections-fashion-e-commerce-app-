import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle displayXL = GoogleFonts.libreCaslonText(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    height: 1.1,
    color: AppColors.primary,
    letterSpacing: -0.8,
  );

  static TextStyle displayLarge = GoogleFonts.libreCaslonText(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.primary,
    fontStyle: FontStyle.italic,
  );

  static TextStyle headline = GoogleFonts.libreCaslonText(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.primary,
    fontStyle: FontStyle.italic,
  );

  static TextStyle title = GoogleFonts.hankenGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  static TextStyle body = GoogleFonts.hankenGrotesk(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.5,
    color: AppColors.onSurface,
  );

  static TextStyle bodySmall = GoogleFonts.hankenGrotesk(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    height: 1.4,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle caption = GoogleFonts.hankenGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle buttonText = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: AppColors.onPrimaryContainer,
  );
}
