import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

ThemeData buildTheme(Brightness brightness) {
  final colors = brightness == Brightness.light
      ? AppColors.light
      : AppColors.dark;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.accent,
      brightness: brightness,
    ),
    fontFamily: 'Poppins',
    extensions: [
      colors,
      const AppSpacing(),
      const AppRadii(),
      AppTypography.standard(colors.textPrimary),
    ],
  );
}
