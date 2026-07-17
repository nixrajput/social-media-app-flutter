import 'package:flutter/material.dart';

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  @override
  AppSpacing copyWith() => this;

  @override
  AppSpacing lerp(AppSpacing? other, double t) => this;
}

@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({this.sm = 8, this.md = 14, this.lg = 20, this.pill = 999});

  final double sm;
  final double md;
  final double lg;
  final double pill;

  @override
  AppRadii copyWith() => this;

  @override
  AppRadii lerp(AppRadii? other, double t) => this;
}
