import 'package:flutter/material.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.display,
    required this.title,
    required this.body,
    required this.label,
    required this.caption,
  });

  final TextStyle display;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle caption;

  static const _base = 'Poppins';

  factory AppTypography.standard(Color color) {
    return AppTypography(
      display: TextStyle(
        fontFamily: _base,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      title: TextStyle(
        fontFamily: _base,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      body: TextStyle(
        fontFamily: _base,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      label: TextStyle(
        fontFamily: _base,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      caption: TextStyle(
        fontFamily: _base,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }

  @override
  AppTypography copyWith() => this;

  @override
  AppTypography lerp(AppTypography? other, double t) => this;
}
