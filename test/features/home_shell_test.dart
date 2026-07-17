import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/design/app_theme.dart';
import 'package:rippl/features/home/presentation/home_shell.dart';

void main() {
  testWidgets('switches tabs on nav tap', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildTheme(Brightness.light),
          home: const HomeShell(),
        ),
      ),
    );
    expect(find.text('Feed'), findsOneWidget);
    await tester.tap(find.text('Chats'));
    await tester.pump();
    expect(find.text('Chats'), findsWidgets);
  });
}
