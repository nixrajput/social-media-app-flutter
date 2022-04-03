abstract class AppUrls {
  static const String baseUrl =
      'https://nixlab-social-api.herokuapp.com/api/v1';

//  Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String updatePasswordEndpoint = '/update/password';
  static const String forgotPasswordEndpoint = '/forgot/password';
  static const String resetPasswordEndpoint = '/reset/password';

  static const String getFollowingPostsEndpoint = '/posts';
  static const String postEndpoint = '/post';
  static const String createPostEndpoint = '$postEndpoint/create';
  static const String likePostEndpoint = '$postEndpoint/like';

  static const String profileDetailsEndpoint = '/me';
  static const String uploadProfilePicEndpoint = '/avatar/me';
  static const String updateProfileDetailsEndpoint = '/update/me';
  static const String checkUsernameAvailableEndpoint = '/check/username';
  static const String updateUsernameEndpoint = '/update/username';
  static const String followUserEndpoint = '/follow';
  static const String getUsersEndpoint = '/users';
  static const String userDetailsEndpoint = '/user';
  static const String getFollowersEndpoint = '/followers';
  static const String getFollowingEndpoint = '/following';
}
