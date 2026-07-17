import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:rippl/core/design/app_theme.dart';
import 'package:rippl/core/design/components/app_badge.dart';
import 'package:rippl/core/design/components/app_button.dart';

void main() {
  for (final brightness in Brightness.values) {
    goldenTest(
      'components render (${brightness.name})',
      fileName: 'components_${brightness.name}',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'primary button',
            child: Theme(
              data: buildTheme(brightness),
              child: AppButton(label: 'Continue', onPressed: () {}),
            ),
          ),
          GoldenTestScenario(
            name: 'badges',
            child: Theme(
              data: buildTheme(brightness),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBadge(kind: VerificationBadge.blue),
                  AppBadge(kind: VerificationBadge.gold),
                  AppBadge(kind: VerificationBadge.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
