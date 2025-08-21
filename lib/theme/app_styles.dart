import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // Helper function to safely get Google Fonts
  static TextStyle _safeGoogleFonts({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    try {
      return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    } catch (e) {
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        fontFamily: 'Poppins',
      );
    }
  }

  // ===== THEME-AWARE TYPOGRAPHY =====
  static TextStyle getHeading1(bool isDark) => _safeGoogleFonts(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.getTextPrimary(isDark),
        height: 1.2,
      );

  static TextStyle getHeading2(bool isDark) => _safeGoogleFonts(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.getTextPrimary(isDark),
        height: 1.3,
      );

  static TextStyle getHeading3(bool isDark) => _safeGoogleFonts(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.getTextPrimary(isDark),
        height: 1.4,
      );

  static TextStyle getHeading4(bool isDark) => _safeGoogleFonts(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.getTextPrimary(isDark),
        height: 1.4,
      );

  static TextStyle getHeading5(bool isDark) => _safeGoogleFonts(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.getTextPrimary(isDark),
        height: 1.5,
      );

  static TextStyle getHeading6(bool isDark) => _safeGoogleFonts(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.getTextPrimary(isDark),
        height: 1.5,
      );

  static TextStyle getBodyLarge(bool isDark) => _safeGoogleFonts(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.getTextPrimary(isDark),
        height: 1.6,
      );

  static TextStyle getBodyMedium(bool isDark) => _safeGoogleFonts(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.getTextPrimary(isDark),
        height: 1.6,
      );

  static TextStyle getBodySmall(bool isDark) => _safeGoogleFonts(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.getTextSecondary(isDark),
        height: 1.6,
      );

  static TextStyle getCaption(bool isDark) => _safeGoogleFonts(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.getTextTertiary(isDark),
        height: 1.5,
      );

  static TextStyle getButton(bool isDark) => _safeGoogleFonts(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.getTextInverse(isDark),
        height: 1.5,
      );

  // ===== SPACING =====
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // ===== BORDER RADIUS =====
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // ===== THEME-AWARE SHADOWS =====
  static List<BoxShadow> getShadowS(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> getShadowM(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.4)
              : Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> getShadowL(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.5)
              : Colors.black.withOpacity(0.12),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  // ===== THEME-AWARE BUTTON STYLES =====
  static ButtonStyle getPrimaryButton(bool isDark) => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.getTextInverse(isDark),
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingL,
          vertical: AppStyles.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
        ),
        elevation: 0,
        textStyle: AppStyles.getButton(isDark),
      );

  static ButtonStyle getSecondaryButton(bool isDark) =>
      ElevatedButton.styleFrom(
        backgroundColor: AppColors.getSurface(isDark),
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingL,
          vertical: AppStyles.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          side: BorderSide(color: AppColors.primary, width: 2),
        ),
        elevation: 0,
        textStyle: AppStyles.getButton(isDark),
      );

  static ButtonStyle getOutlineButton(bool isDark) => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingL,
          vertical: AppStyles.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
        ),
        side: BorderSide(color: AppColors.primary, width: 2),
        textStyle: AppStyles.getButton(isDark),
      );

  // ===== THEME-AWARE CARD STYLES =====
  static BoxDecoration getCardDecoration(bool isDark) => BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppStyles.radiusL),
        boxShadow: AppStyles.getShadowS(isDark),
        border: Border.all(color: AppColors.getDivider(isDark), width: 1),
      );

  // ===== THEME-AWARE INPUT STYLES =====
  static InputDecoration getInputDecoration(bool isDark) => InputDecoration(
        filled: true,
        fillColor: AppColors.getSurface(isDark),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.getDivider(isDark)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.getDivider(isDark)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingM,
          vertical: AppStyles.spacingM,
        ),
      );

  // ===== LEGACY STYLES (for backward compatibility) =====
  // These will be deprecated in favor of theme-aware versions
  static TextStyle get heading1 => getHeading1(false);
  static TextStyle get heading2 => getHeading2(false);
  static TextStyle get heading3 => getHeading3(false);
  static TextStyle get heading4 => getHeading4(false);
  static TextStyle get heading5 => getHeading5(false);
  static TextStyle get heading6 => getHeading6(false);
  static TextStyle get bodyLarge => getBodyLarge(false);
  static TextStyle get bodyMedium => getBodyMedium(false);
  static TextStyle get bodySmall => getBodySmall(false);
  static TextStyle get caption => getCaption(false);
  static TextStyle get button => getButton(false);

  static List<BoxShadow> get shadowS => getShadowS(false);
  static List<BoxShadow> get shadowM => getShadowM(false);
  static List<BoxShadow> get shadowL => getShadowL(false);

  static ButtonStyle get primaryButton => getPrimaryButton(false);
  static ButtonStyle get secondaryButton => getSecondaryButton(false);
  static ButtonStyle get outlineButton => getOutlineButton(false);

  static BoxDecoration get cardDecoration => getCardDecoration(false);
  static InputDecoration get inputDecoration => getInputDecoration(false);
}
