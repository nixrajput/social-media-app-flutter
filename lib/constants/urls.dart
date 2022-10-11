abstract class AppUrls {
  /// Base URLs
  static const String locationUrl = 'http://ip-api.com/json';
  static const String baseUrl = 'https://social-api.nixlab.co.in/api/v1';
  static const String githubApiUrl = 'https://api.github.com';

  ///  Endpoints
  static const String serverHealthEndpoint = '/health';
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String forgotPasswordEndpoint = '/forgot-password';
  static const String resetPasswordEndpoint = '/reset-password';
  static const String verifyAccountEndpoint = '/verify-account';

  static const String getPostsEndpoint = '/get-posts';
  static const String postEndpoint = '/post';
  static const String searchPostsEndpoint = '/search-posts';
  static const String createPostEndpoint = '/create-post';
  static const String likePostEndpoint = '/like-post';
  static const String getPostLikedUsersEndpoint = '/get-post-liked-users';
  static const String searchTagEndpoint = '/search-tag';
  static const String getPostsByTagEndpoint = '/get-posts-by-tag';
  static const String getTrendingPostsEndpoint = '/get-trending-posts';

  static const String addCommentEndpoint = '/add-comment';
  static const String getCommentsEndpoint = '/get-comments';
  static const String likeCommentEndpoint = '/like-comment';
  static const String deleteCommentEndpoint = '/delete-comment';

  static const String profileDetailsEndpoint = '/me';
  static const String uploadProfilePicEndpoint = '/upload-profile-picture';
  static const String deleteProfilePicEndpoint = '/remove-profile-picture';
  static const String changePasswordEndpoint = '/change-password';
  static const String updateProfileEndpoint = '/update-profile';
  static const String checkUsernameEndpoint = '/check-username';
  static const String changeUsernameEndpoint = '/change-username';
  static const String deleteProfileEndpoint = '/delete-profile';
  static const String validateTokenEndpoint = '/validate-token';
  static const String addChangePhoneEndpoint = '/add-change-phone';
  static const String changeEmailEndpoint = '/change-email';
  static const String verifyPasswordEndpoint = '/verify-password';
  static const String deactivateAccountEndpoint = '/deactivate-account';
  static const String reactivateAccountEndpoint = '/reactivate-account';

  static const String saveLoginInfoEndpoint = '/save-device-info';
  static const String getLoginInfoEndpoint = '/get-device-info';
  static const String deleteDeviceInfoEndpoint = '/delete-device-info';

  static const String preKeyBundleEndpoint = '/pre-key-bundle';
  static const String deviceIdEndpoint = '/device-id';

  static const String searchUserEndpoint = '/search-user';
  static const String followUserEndpoint = '/follow-user';
  static const String getFollowRequests = '/get-follow-requests';
  static const String acceptFollowRequestEndpoint = '/accept-follow-request';
  static const String removeFollowRequestEndpoint = '/remove-follow-request';
  static const String cancelFollowRequestEndpoint = '/cancel-follow-request';
  static const String getRecommendUsersEndpoint = '/get-recommend-users';
  static const String userDetailsEndpoint = '/user-details';
  static const String getFollowersEndpoint = '/get-followers';
  static const String getFollowingEndpoint = '/get-followings';
  static const String searchFollowersEndpoint = '/search-followers';
  static const String searchFollowingEndpoint = '/search-followings';
  static const String getUserPostsEndpoint = '/get-user-posts';

  static const String getNotificationsEndpoint = '/get-notifications';
  static const String markNotificationsReadEndpoint = '/mark-read-notification';
  static const String deleteNotificationsEndpoint = '/delete-notification';

  static const String getAllLastMessageEndpoint = '/get-all-last-messages';
  static const String getMessagesByIdEndpoint = '/get-messages-by-id';

  static const String fcmTokenEndpoint = '/fcm-token';

  static const String checkAppUpdateEndpoint =
      '/repos/nixrajput/social-media-app-flutter/releases/latest';
}
