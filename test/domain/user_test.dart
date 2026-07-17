import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/domain/models/user.dart';

void main() {
  test('User round-trips json', () {
    final json = {
      'id': 'u1',
      'username': 'nik',
      'email': 'n@e.com',
      'displayName': 'Nik',
      'avatarUrl': null,
      'isPrivate': false,
      'createdAt': '2026-01-01T00:00:00.000Z',
    };
    final u = User.fromJson(json);
    expect(u.username, 'nik');
    expect(u.toJson()['id'], 'u1');
  });
}
