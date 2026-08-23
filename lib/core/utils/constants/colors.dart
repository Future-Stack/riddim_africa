import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Brand ─────────────────────────────────────────────
  static const Color primary = Color(0xFF1A0D07);
  static const Color primaryappbrown = Color(0xFF22140A);
  static const Color primaryappbrownsecond = Color(0xFF382111);

  static const Color secondary = Color(0xFFBB483D);
  static const Color secondary2 = Color(0xFFBB483D);
  static const Color accent = Color(0xFF89A7FF);
  static const Color multicolor = Color(0xFFF4D242);
  static const Color primarytext = Color(0xFFA08070);
  static const Color onboardingtext = Color(0xFFB1A290);

  static const Color onboardingbutton = Color(0xFFE6B650);
  static const Color textfieldelementcolor = Color(0xFFF0E8D8);
  static const Color purple = Color(0xFF6F2C57);
  static const Color appbardivider = Color(0xFF271B16);

  //border color
  static const Color bordercolor = Color(0xFF377A7D);
  static const Color textfieldcolor = Color(0xFF212B36);
  static const Color cardBorder = Color(0xFF655042);
  static const Color cardBorder2 = Color(0x26AD46FF);

  //background color
  static const Color backgroundcolor = Color(0xFF2C1A0D);
  static const Color iconBackground = Color(0x00BC7D26);

  // ─── Status & Revenue Palette ────────────────────────
  static const Color success = Color(0xFF3BB515);
  static const Color greenBright = Color(0xFF00E676);
  static const Color greenDark = Color(0xFF143521);
  static const Color greenDeep = Color(0xFF1B4324);

  static const Color warning = Color(0xFFF59E0B);
  static const Color amberBright = Color(0xFFF5A623);
  static const Color amberDark = Color(0xFF383015);
  static const Color amberDeep = Color(0xFF3B2800);

  static const Color error = Color(0xFFDB321C);
  static const Color info = Color(0xFF3B82F6);

  static const Color gold = Color(0xFFE5B282);
  static const Color goldText = Color(0xFFE5B282);
  static const Color chartLine = Color(0xFFE5B282);
  static const Color subCardBrown = Color(0xFF8B4E38);
  static const Color heroGradientStart = Color(0xFF5A2814);
  static const Color heroGradientEnd = Color(0xFF381A0D);

  static const Color tealDark = Color(0xFF183D3D);
  static const Color tealDarkBg = Color(0xFF142E2E);
  static const Color tealBorder = Color(0xFF235A5A);
  static const Color tabUnderlineTeal = Color(0xFF377A7D);

  // ─── Light Theme ───────────────────────────────────────
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF9FAFB);
  static const Color lightSurfaceVariant = Color(0xFFF1F3F5);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFEEEEEE);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextDisabled = Color(0xFF9CA3AF);
  static const Color lightTextInverse = Color(0xFFFFFFFF);

  // ─── Dark Theme ────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F1115);
  static const Color darkSurface = Color(0xFF1A1D23);
  static const Color darkSurfaceVariant = Color(0xFF23272F);
  static const Color darkBorder = Color(0xFF2E333B);
  static const Color darkDivider = Color(0xFF2A2E36);

  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFFB0B7C3);
  static const Color darkTextDisabled = Color(0xFF6B7280);
  static const Color darkTextInverse = Color(0xFF111827);

  // ─── Neutral ───────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // ─── Gradient Dark Theme ──────────────────────────────────────────
  static const Gradient primaryDarkGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [lightTextPrimary, lightTextSecondary],
  );

  // revinue card gradient
  static const Gradient revenueCardGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.8, -0.99),
    colors: [AppColors.heroGradientStart, AppColors.secondary],
  );

  // ─── Theme-aware helpers ───────────────────────────────
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) =>
      isDark(context) ? darkBackground : lightBackground;

  static Color surface(BuildContext context) =>
      isDark(context) ? darkSurface : lightSurface;

  static Color surfaceVariant(BuildContext context) =>
      isDark(context) ? darkSurfaceVariant : lightSurfaceVariant;

  static Color border(BuildContext context) =>
      isDark(context) ? darkBorder : lightBorder;

  static Color divider(BuildContext context) =>
      isDark(context) ? darkDivider : lightDivider;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? darkTextPrimary : lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? darkTextSecondary : lightTextSecondary;

  static Color textDisabled(BuildContext context) =>
      isDark(context) ? darkTextDisabled : lightTextDisabled;

  static Color textInverse(BuildContext context) =>
      isDark(context) ? darkTextInverse : lightTextInverse;
}
