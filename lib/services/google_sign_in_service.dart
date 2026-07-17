import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/config/env.dart';

part 'google_sign_in_service.g.dart';

abstract interface class GoogleSignInService {
  // Returns a Google ID token, or null if the user cancelled the prompt.
  Future<String?> signInIdToken();
}

class GoogleSignInServiceImpl implements GoogleSignInService {
  bool _initialized = false;

  @override
  Future<String?> signInIdToken() async {
    final signIn = GoogleSignIn.instance;
    if (!_initialized) {
      await signIn.initialize(
        serverClientId: OAuthConfig.googleServerClientId.isEmpty
            ? null
            : OAuthConfig.googleServerClientId,
      );
      _initialized = true;
    }
    try {
      final account = await signIn.authenticate();
      return account.authentication.idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }
}

@riverpod
GoogleSignInService googleSignInService(Ref ref) => GoogleSignInServiceImpl();
