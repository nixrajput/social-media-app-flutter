import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/config/env.dart';

void main() {
  test('ApiConfig has a versioned base url', () {
    expect(ApiConfig.baseUrl, endsWith('/api/v1'));
  });
}
