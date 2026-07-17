import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/errors/api_error.dart';

void main() {
  test('parses the server envelope', () {
    final e = ApiError.fromResponse(400, {
      'error': {
        'code': 'VALIDATION',
        'message': 'email: invalid',
        'requestId': 'r1',
      },
    });
    expect(e.code, 'VALIDATION');
    expect(e.message, 'email: invalid');
    expect(e.requestId, 'r1');
  });

  test('falls back for a non-envelope body', () {
    final e = ApiError.fromResponse(500, 'gateway boom');
    expect(e.code, 'INTERNAL');
    expect(e.status, 500);
  });
}
