import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.border,
    required this.danger,
    required this.presenceGradient,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color border;
  final Color danger;

  // Reserved for presence/E2EE states ONLY (spec section 9). Never a generic accent.
  final LinearGradient presenceGradient;

  static const _violet = Color(0xFF6C5CE7);
  static const _green = Color(0xFF2ECC9B);

  static const light = AppColors(
    background: Color(0xFFFAFAF7),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF1F0EC),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6B6B6B),
    accent: _violet,
    border: Color(0xFFE4E3DE),
    danger: Color(0xFFD64545),
    presenceGradient: LinearGradient(colors: [_violet, _green]),
  );

  static const dark = AppColors(
    background: Color(0xFF0E0E10),
    surface: Color(0xFF17171A),
    surfaceMuted: Color(0xFF202024),
    textPrimary: Color(0xFFF2F2F2),
    textSecondary: Color(0xFF9A9AA0),
    accent: Color(0xFF8B7CF8),
    border: Color(0xFF2A2A2E),
    danger: Color(0xFFE06666),
    presenceGradient: LinearGradient(colors: [Color(0xFF8B7CF8), _green]),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? border,
    Color? danger,
    LinearGradient? presenceGradient,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      border: border ?? this.border,
      danger: danger ?? this.danger,
      presenceGradient: presenceGradient ?? this.presenceGradient,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      border: Color.lerp(border, other.border, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      presenceGradient: t < 0.5 ? presenceGradient : other.presenceGradient,
    );
  }
}
