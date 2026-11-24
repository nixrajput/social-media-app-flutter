import 'package:flutter_test/flutter_test.dart';
import 'package:social_media_app/utils/utility.dart';

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
}
