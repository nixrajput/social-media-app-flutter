abstract class AppUrls {
  /// Base URLs
  static const baseUrl = 'https://api.nixlab.co.in/api/v1';
  static const webSocketUrl = 'wss://api.nixlab.co.in/api/v1/ws';

  ///  Endpoints
  static const serverHealthEndpoint = '/health';
  static const loginEndpoint = '/login';
  static const registerEndpoint = '/register';
  static const forgotPasswordEndpoint = '/forgot-password';
  static const resetPasswordEndpoint = '/reset-password';
  static const verifyAccountEndpoint = '/verify-account';

  static const sendOtpToEmailEndpoint = '/send-otp-to-email';
  static const verifyOtpFromEmailEndpoint = '/verify-email-otp';
  static const sendOtpToPhoneEndpoint = '/send-otp-to-phone';
  static const verifyOtpFromPhoneEndpoint = '/verify-phone-otp';

  static const getPostsEndpoint = '/get-posts';
  static const postEndpoint = '/post';
  static const searchPostsEndpoint = '/search-posts';
  static const createPostEndpoint = '/create-post';

  static const createPollEndpoint = '/create-poll';
  static const voteToPollEndpoint = '/vote-to-poll';

  static const likePostEndpoint = '/like-post';
  static const getPostLikedUsersEndpoint = '/get-post-liked-users';
  static const searchTagEndpoint = '/search-tag';
  static const getPostsByTagEndpoint = '/get-posts-by-tag';
  static const getTrendingPostsEndpoint = '/get-trending-posts';

  static const addCommentEndpoint = '/add-comment';
  static const getCommentsEndpoint = '/get-comments';
  static const likeCommentEndpoint = '/like-comment';
  static const deleteCommentEndpoint = '/delete-comment';

  static const profileDetailsEndpoint = '/me';
  static const uploadProfilePicEndpoint = '/upload-profile-picture';
  static const deleteProfilePicEndpoint = '/remove-profile-picture';
  static const changePasswordEndpoint = '/change-password';
  static const updateProfileEndpoint = '/update-profile';
  static const checkUsernameEndpoint = '/check-username';
  static const changeUsernameEndpoint = '/change-username';
  static const deleteProfileEndpoint = '/delete-profile';
  static const validateTokenEndpoint = '/validate-token';
  static const addChangePhoneEndpoint = '/add-change-phone';
  static const changeEmailEndpoint = '/change-email';
  static const verifyPasswordEndpoint = '/verify-password';
  static const deactivateAccountEndpoint = '/deactivate-account';
  static const reactivateAccountEndpoint = '/reactivate-account';

  static const loginInfoEndpoint = '/login-info';
  static const getLoginHistoryEndpoint = '/get-login-history';
  static const verifyLoginInfoEndpoint = '/verify-login-info';
  static const logoutFromOtherDevicesEndpoint = '/logout-all-other-devices';

  static const preKeyBundleEndpoint = '/pre-key-bundle';

  static const getLocationInfoEndpoint = '/get-location-info';

  static const reportUserEndpoint = '/report-user';
  static const reportPostEndpoint = '/report-post';
  static const reportCommentEndpoint = '/report-comment';

  static const requestVerificationEndpoint = '/request-verification';

  static const searchUserEndpoint = '/search-user';
  static const followUserEndpoint = '/follow-user';
  static const getFollowRequests = '/get-follow-requests';
  static const acceptFollowRequestEndpoint = '/accept-follow-request';
  static const removeFollowRequestEndpoint = '/remove-follow-request';
  static const cancelFollowRequestEndpoint = '/cancel-follow-request';
  static const getRecommendUsersEndpoint = '/get-recommend-users';
  static const userDetailsEndpoint = '/user-details';
  static const getFollowersEndpoint = '/get-followers';
  static const getFollowingEndpoint = '/get-followings';
  static const searchFollowersEndpoint = '/search-followers';
  static const searchFollowingEndpoint = '/search-followings';
  static const getUserPostsEndpoint = '/get-user-posts';

  static const getNotificationsEndpoint = '/get-notifications';
  static const markNotificationsReadEndpoint = '/mark-read-notification';
  static const deleteNotificationsEndpoint = '/delete-notification';

  static const getAllLastMessageEndpoint = '/get-all-last-messages';
  static const getMessagesByIdEndpoint = '/get-messages-by-id';

  static const fcmTokenEndpoint = '/fcm-token';

  static const checkAppUpdateEndpoint = '/check-update';
}
