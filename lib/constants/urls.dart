abstract class AppUrls {
  // Base URL
  static const String baseUrl =
      'https://nixlab-social-api.herokuapp.com/api/v1';

//  Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String updatePasswordEndpoint = '/change-password';
  static const String forgotPasswordEndpoint = '/forgot-password';
  static const String resetPasswordEndpoint = '/reset-password';

  static const String getFollowingPostsEndpoint = '/get-posts';
  static const String postEndpoint = '/post';
  static const String createPostEndpoint = '/create-post';
  static const String likePostEndpoint = '/like-post';

  static const String addCommentEndpoint = '/add-comment';
  static const String getCommentsEndpoint = '/get-comments';
  static const String likeCommentEndpoint = '/like-comment';
  static const String deleteCommentEndpoint = '/delete-comment';

  static const String profileDetailsEndpoint = '/me';
  static const String uploadProfilePicEndpoint = '/upload-avatar';
  static const String updateProfileDetailsEndpoint = '/update-profile-details';
  static const String checkUsernameAvailableEndpoint = '/check-username';
  static const String updateUsernameEndpoint = '/change-username';
  static const String verifyEmailEndpoint = '/verify-email';
  static const String deleteProfileEndpoint = '/delete-profile';

  static const String searchUserEndpoint = '/search-user';
  static const String followUserEndpoint = '/follow-user';
  static const String getUsersEndpoint = '/get-random-users';
  static const String userDetailsEndpoint = '/profile-details';
  static const String getFollowersEndpoint = '/get-followers-list';
  static const String getFollowingEndpoint = '/get-following-list';
}
