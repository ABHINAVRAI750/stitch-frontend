import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color surface = Color(0xFF0E1323);
  static const Color surfaceDim = Color(0xFF0E1323);
  static const Color surfaceBright = Color(0xFF34394A);
  static const Color surfaceContainerLowest = Color(0xFF080D1D);
  static const Color surfaceContainerLow = Color(0xFF161B2B);
  static const Color surfaceContainer = Color(0xFF1A1F30);
  static const Color surfaceContainerHigh = Color(0xFF25293A);
  static const Color surfaceContainerHighest = Color(0xFF2F3446);

  static const Color onSurface = Color(0xFFDEE1F9);
  static const Color onSurfaceVariant = Color(0xFFBBC9CD);
  static const Color inverseSurface = Color(0xFFDEE1F9);
  static const Color inverseOnSurface = Color(0xFF2B3041);
  static const Color outline = Color(0xFF859397);
  static const Color outlineVariant = Color(0xFF3C494C);

  static const Color primary = Color(0xFF8AEBFF);
  static const Color onPrimary = Color(0xFF00363E);
  static const Color primaryContainer = Color(0xFF22D3EE);
  static const Color onPrimaryContainer = Color(0xFF005763);
  static const Color primaryFixed = Color(0xFFA2EEFF);
  static const Color primaryFixedDim = Color(0xFF2FD9F4);
  static const Color onPrimaryFixed = Color(0xFF001F25);

  static const Color secondary = Color(0xFFD0BCFF);
  static const Color onSecondary = Color(0xFF3C0091);
  static const Color secondaryContainer = Color(0xFF571BC1);
  static const Color onSecondaryContainer = Color(0xFFC4ABFF);
  static const Color secondaryFixed = Color(0xFFE9DDFF);
  static const Color secondaryFixedDim = Color(0xFFD0BCFF);

  static const Color tertiary = Color(0xFF68F5B8);
  static const Color onTertiary = Color(0xFF003824);
  static const Color tertiaryContainer = Color(0xFF46D89D);
  static const Color onTertiaryContainer = Color(0xFF005A3D);
  static const Color tertiaryFixed = Color(0xFF6FFBBE);

  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  static const Color background = Color(0xFF0E1323);
  static const Color onBackground = Color(0xFFDEE1F9);
}

class AppTypography {
  AppTypography._();

  static const List<String> sansFallbacks = [
    'Inter',
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
    'sans-serif'
  ];

  static const List<String> monoFallbacks = [
    'JetBrains Mono',
    'Cascadia Code',
    'Consolas',
    'Courier New',
    'monospace'
  ];

  // Headings
  static const TextStyle headlineXl = TextStyle(
    fontFamilyFallback: sansFallbacks,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
    letterSpacing: -0.64,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineLg = TextStyle(
    fontFamilyFallback: sansFallbacks,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    letterSpacing: -0.2,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSm = TextStyle(
    fontFamilyFallback: sansFallbacks,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    letterSpacing: -0.08,
    color: AppColors.onSurface,
  );

  // Body
  static const TextStyle bodyMd = TextStyle(
    fontFamilyFallback: sansFallbacks,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.onSurface,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamilyFallback: sansFallbacks,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 18 / 13,
    color: AppColors.onSurfaceVariant,
  );

  // Code / Telemetry
  static const TextStyle metricDisplay = TextStyle(
    fontFamilyFallback: monoFallbacks,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 32 / 28,
    letterSpacing: -0.84,
    color: AppColors.onSurface,
  );

  static const TextStyle codeMd = TextStyle(
    fontFamilyFallback: monoFallbacks,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 18 / 13,
    color: AppColors.onSurface,
  );

  static const TextStyle codeSm = TextStyle(
    fontFamilyFallback: monoFallbacks,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 16 / 11,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelCaps = TextStyle(
    fontFamilyFallback: monoFallbacks,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 14 / 10,
    letterSpacing: 0.8,
    color: AppColors.outline,
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.surface,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
    ),
    dividerColor: AppColors.outlineVariant.withValues(alpha: 0.3),
    fontFamilyFallback: AppTypography.sansFallbacks,
  );
}
