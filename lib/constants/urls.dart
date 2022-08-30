abstract class AppUrls {
  // Base URL
  static const String locationUrl = 'http://ip-api.com/json';
  static const String baseUrl = 'https://social-api.nixlab.co.in/api/v1';

//  Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String forgotPasswordEndpoint = '/forgot-password';
  static const String resetPasswordEndpoint = '/reset-password';
  static const String verifyAccountEndpoint = '/verify-account';

  static const String getPostsEndpoint = '/get-posts';
  static const String postEndpoint = '/post';
  static const String createPostEndpoint = '/create-post';
  static const String likePostEndpoint = '/like-post';

  static const String addCommentEndpoint = '/add-comment';
  static const String getCommentsEndpoint = '/get-comments';
  static const String likeCommentEndpoint = '/like-comment';
  static const String deleteCommentEndpoint = '/delete-comment';

  static const String profileDetailsEndpoint = '/me';
  static const String uploadProfilePicEndpoint = '/upload-avatar';
  static const String deleteProfilePicEndpoint = '/delete-avatar';
  static const String changePasswordEndpoint = '/change-password';
  static const String updateProfileEndpoint = '/update-profile';
  static const String checkUsernameEndpoint = '/check-username';
  static const String changeUsernameEndpoint = '/change-username';
  static const String verifyEmailEndpoint = '/verify-email';
  static const String deleteProfileEndpoint = '/delete-profile';

  static const String saveLoginInfoEndpoint = '/save-device-info';
  static const String getLoginInfoEndpoint = '/get-device-info';
  static const String deleteDeviceInfoEndpoint = '/delete-device-info';

  static const String searchUserEndpoint = '/search-user';
  static const String followUserEndpoint = '/follow-user';
  static const String getRecommendUsersEndpoint = '/get-recommend-users';
  static const String userDetailsEndpoint = '/user-details';
  static const String getFollowersEndpoint = '/get-followers';
  static const String getFollowingEndpoint = '/get-followings';

  static const String getNotifications = '/get-notifications';
}
