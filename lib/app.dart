import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/design/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/settings/presentation/theme_mode_controller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final mode =
        ref.watch(themeModeControllerProvider).value ?? ThemeMode.system;
    return MaterialApp.router(
      title: 'Rippl',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: mode,
      routerConfig: router,
    );
  }
}
