import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/design/app_colors.dart';
import 'package:rippl/core/design/app_theme.dart';

void main() {
  test('themes expose AppColors for both brightnesses', () {
    final light = buildTheme(Brightness.light);
    final dark = buildTheme(Brightness.dark);
    expect(light.extension<AppColors>(), isNotNull);
    expect(dark.extension<AppColors>(), isNotNull);
    expect(
      light.extension<AppColors>()!.surface,
      isNot(equals(dark.extension<AppColors>()!.surface)),
    );
  });

  test('presence gradient has two stops reserved for E2EE', () {
    final colors = buildTheme(Brightness.light).extension<AppColors>()!;
    expect(colors.presenceGradient.colors.length, 2);
  });
}
