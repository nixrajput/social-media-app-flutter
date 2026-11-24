import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class _RecordingLauncher extends UrlLauncherPlatform {
  final launched = <String>[];

  @override
  LinkDelegate? get linkDelegate => null;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    launched.add(url);
    return true;
  }
}

void main() {
  test('opens web and mail links only', () {
    for (final url in [
      'https://nixlab.co.in',
      'http://example.com',
      'mailto:someone@example.com',
    ]) {
      expect(AppUtility.canOpenUrl(Uri.parse(url)), isTrue, reason: url);
    }
    for (final url in [
      'intent://scan/#Intent;scheme=zxing;end',
      'file:///data/data/com.nixlab.rippl/shared_prefs/x.xml',
      'javascript:alert(1)',
      'tel:123',
      'example.com',
    ]) {
      expect(AppUtility.canOpenUrl(Uri.parse(url)), isFalse, reason: url);
    }
  });

  testWidgets('openUrl never launches an intent: link', (tester) async {
    final launcher = _RecordingLauncher();
    UrlLauncherPlatform.instance = launcher;
    await tester.pumpWidget(
      ScreenUtilInit(
        builder: (_, _) => GetMaterialApp(
          theme: ThemeData(
            snackBarTheme: const SnackBarThemeData(
              backgroundColor: Colors.black,
              contentTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          home: const SizedBox(),
        ),
      ),
    );

    await AppUtility.openUrl(
      Uri.parse('intent://scan/#Intent;scheme=zxing;end'),
    );
    await AppUtility.openUrl(Uri.parse('https://nixlab.co.in'));

    expect(launcher.launched, ['https://nixlab.co.in']);
    await tester.pump(const Duration(seconds: 5));
  });
}
