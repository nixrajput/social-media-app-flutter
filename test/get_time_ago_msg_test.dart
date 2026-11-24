import 'package:flutter_test/flutter_test.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/helpers/get_time_ago_msg.dart';

void main() {
  test('formats relative times in the compact style', () {
    GetTimeAgo.registerLocale('en', customMessages);
    final now = DateTime.now();

    expect(
      GetTimeAgo.parse(now.subtract(const Duration(seconds: 30))),
      '30s ago',
    );
    expect(
      GetTimeAgo.parse(now.subtract(const Duration(minutes: 5))),
      '5m ago',
    );
    expect(GetTimeAgo.parse(now.subtract(const Duration(hours: 3))), '3h ago');
    expect(GetTimeAgo.parse(now.subtract(const Duration(days: 2))), '2d ago');
  });
}
