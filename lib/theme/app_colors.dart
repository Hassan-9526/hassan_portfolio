import 'package:flutter/material.dart';

class AppColors {
  // ===== CENTRAL COLOR PALETTE =====
  // Change this base color to update the entire app theme
  static const Color _baseColor =
      Color(0xFF3A86FF); // Indigo bluw - Change this to update theme

  // Primary Colors - Derived from base color
  static Color get primary => _baseColor;
  static Color get primaryLight => _baseColor.withOpacity(0.8);
  static Color get primaryDark => _baseColor.withOpacity(0.6);

  // Secondary Colors - Complementary to primary
  static Color get secondary => _baseColor.withOpacity(0.7);
  static Color get secondaryLight => _baseColor.withOpacity(0.5);
  static Color get secondaryDark => _baseColor.withOpacity(0.9);

  // ===== LIGHT THEME COLORS =====
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE5E7EB);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);
  static const Color lightTextInverse = Color(0xFFFFFFFF);

  // ===== DARK THEME COLORS =====
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF334155);
  static const Color darkDivider = Color(0xFF475569);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkTextInverse = Color(0xFF0F172A);

  // ===== STATUS COLORS =====
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ===== GRADIENTS =====
  static LinearGradient get primaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primary, primaryLight],
      );

  static LinearGradient get secondaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [secondary, secondaryLight],
      );

  // ===== THEME-AWARE COLOR GETTERS =====
  static Color getBackground(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  static Color getSurface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color getCard(bool isDark) => isDark ? darkCard : lightCard;
  static Color getDivider(bool isDark) => isDark ? darkDivider : lightDivider;
  static Color getButton(bool isDark) => isDark ? darkDivider : darkDivider;

  static Color getTextPrimary(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;
  static Color getTextSecondary(bool isDark) =>
      isDark ? darkTextSecondary : lightTextSecondary;
  static Color getTextTertiary(bool isDark) =>
      isDark ? darkTextTertiary : lightTextTertiary;
  static Color getTextInverse(bool isDark) =>
      isDark ? darkTextInverse : lightTextInverse;
}
