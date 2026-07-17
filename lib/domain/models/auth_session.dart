import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_tokens.dart';
import 'user.dart';

part 'auth_session.freezed.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required User user,
    required AuthTokens tokens,
    required String deviceId,
  }) = _AuthSession;
}
