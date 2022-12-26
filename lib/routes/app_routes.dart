part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = _Routes.splash;
  static const maintenance = _Routes.maintenance;
  static const welcome = _Routes.welcome;
  static const offline = _Routes.offline;
  static const error = _Routes.error;
  static const noNetwork = _Routes.noNetwork;
  static const home = _Routes.home;

  static const chats = _Routes.chats;
  static const chatDetails = _Routes.chatDetails;
  static const chatSettings = _Routes.chatSettings;

  static const login = _Routes.login;
  static const register = _Routes.register;

  static const sendOtpToEmail = _Routes.sendOtpToEmail;
  static const sendOtpToPhone = _Routes.sendOtpToPhone;
  static const verifyOtp = _Routes.verifyOtp;

  static const accountSettings = _Routes.accountSettings;
  static const securitySettings = _Routes.securitySettings;
  static const privacySettings = _Routes.privacySettings;
  static const helpSettings = _Routes.helpSettings;
  static const aboutSettings = _Routes.aboutSettings;
  static const themeSettings = _Routes.themeSettings;

  static const blueTickVerificationSettings =
      _Routes.blueTickVerificationSettings;
  static const blueTickVerification = _Routes.blueTickVerification;
  static const loginActivitySettings = _Routes.loginActivitySettings;
  static const accountPrivacySettings = _Routes.accountPrivacySettings;
  static const onlineStatusSettings = _Routes.onlineStatusSettings;
  static const twoFASettings = _Routes.twoFASettings;
  static const postSettings = _Routes.postSettings;
  static const commentsSettings = _Routes.commentsSettings;
  static const momentsSettings = _Routes.momentsSettings;
  static const blockedUsersSettings = _Routes.blockedUsersSettings;
  static const changeEmailSettings = _Routes.changeEmailSettings;
  static const changePhoneSettings = _Routes.changePhoneSettings;
  static const applyForSelfVerifySettings = _Routes.applyForSelfVerifySettings;
  static const applyForBlueTickSettings = _Routes.applyForBlueTickSettings;
  static const deactivateAccountSettings = _Routes.deactivateAccountSettings;
  static const reportIssueSettings = _Routes.reportIssueSettings;
  static const sendSuggestionsSettings = _Routes.sendSuggestionsSettings;

  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const changePassword = _Routes.changePassword;
  static const sendVerifyAccountOtp = _Routes.sendVerifyAccountOtp;
  static const verifyAccount = _Routes.verifyAccount;
  static const sendVerifyEmailOtp = _Routes.sendVerifyEmailOtp;
  static const verifyEmail = _Routes.verifyEmail;
  static const verifyPassword = _Routes.verifyPassword;
  static const reactivateAccount = _Routes.reactivateAccount;

  static const editProfile = _Routes.editProfile;
  static const editName = _Routes.editName;
  static const editUsername = _Routes.editUsername;
  static const editAbout = _Routes.editAbout;
  static const editDob = _Routes.editDob;
  static const editGender = _Routes.editGender;
  static const editPhone = _Routes.editPhone;
  static const editProfession = _Routes.editProfession;
  static const editLocation = _Routes.editLocation;
  static const editWebsite = _Routes.editWebsite;

  static const following = _Routes.following;
  static const followers = _Routes.followers;
  static const followRequests = _Routes.followRequests;

  static const createPost = _Routes.createPost;
  static const createPoll = _Routes.createPoll;
  static const pollPreview = _Routes.pollPreview;
  static const postPreview = _Routes.postPreview;
  static const addCaption = _Routes.addCaption;
  static const postDetails = _Routes.postDetails;
  static const postMediaView = _Routes.postMediaView;
  static const comments = _Routes.comments;
  static const postLikedUsers = _Routes.postLikedUsers;

  static const profile = _Routes.profile;
  static const userProfile = _Routes.userProfile;

  static const appUpdate = _Routes.appUpdate;
}

abstract class _Routes {
  static const splash = '/';
  static const maintenance = '/maintenance';
  static const welcome = '/welcome';
  static const offline = '/offline';
  static const error = '/error';
  static const noNetwork = '/no_network';
  static const home = '/home';

  static const chats = '/chats';
  static const chatDetails = '/chatDetails';
  static const chatSettings = '/chatSettings';

  static const login = '/login';
  static const register = '/register';

  static const sendOtpToEmail = '/sendOtpToEmail';
  static const sendOtpToPhone = '/sendOtpToPhone';
  static const verifyOtp = '/verifyOtp';

  static const accountSettings = "/account_settings";
  static const securitySettings = "/security_settings";
  static const privacySettings = "/privacy_settings";
  static const helpSettings = "/help_settings";
  static const aboutSettings = "/about_settings";
  static const themeSettings = "/theme_settings";

  static const blueTickVerificationSettings =
      "/blue_tick_verification_settings";
  static const blueTickVerification = "/blue_tick_verification";
  static const accountPrivacySettings = '/account_privacy_settings';
  static const onlineStatusSettings = '/online_status_settings';
  static const twoFASettings = '/two_fa_settings';
  static const postSettings = '/post_settings';
  static const commentsSettings = '/comments_settings';
  static const momentsSettings = '/moments_settings';
  static const blockedUsersSettings = '/blocked_users_settings';
  static const loginActivitySettings = '/login_activity_settings';
  static const changeEmailSettings = '/change_email_settings';
  static const changePhoneSettings = '/change_phone_settings';
  static const applyForSelfVerifySettings = '/apply_for_self_verify_settings';
  static const applyForBlueTickSettings = '/apply_for_blue_tick_settings';
  static const deactivateAccountSettings = '/deactivate_account_settings';
  static const reportIssueSettings = '/report_issue';
  static const sendSuggestionsSettings = '/send_suggestions';

  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const changePassword = '/change_password';
  static const sendVerifyAccountOtp = '/send_account_verification_otp';
  static const verifyAccount = '/verify_account';
  static const sendVerifyEmailOtp = '/send_email_verification_otp';
  static const verifyEmail = '/verify_email';
  static const verifyPassword = '/verify_password';
  static const reactivateAccount = '/reactivate_account';

  static const editProfile = '/edit_profile';
  static const editName = '/edit_name';
  static const editUsername = '/edit_username';
  static const editAbout = '/edit_about';
  static const editDob = '/edit_dob';
  static const editGender = '/edit_gender';
  static const editPhone = '/edit_phone';
  static const editProfession = '/edit_profession';
  static const editLocation = '/edit_location';
  static const editWebsite = '/edit_website';

  static const following = '/following';
  static const followers = '/followers';
  static const followRequests = '/follow_requests';

  static const createPost = '/create_post';
  static const createPoll = '/create_poll';
  static const pollPreview = '/poll_preview';
  static const postPreview = '/postPreview';
  static const addCaption = '/add-caption';
  static const postDetails = '/post_details';
  static const postMediaView = '/post_media_view';
  static const comments = '/comments';
  static const postLikedUsers = '/post_liked_users';

  static const profile = '/profile';
  static const userProfile = '/user_profile';

  static const appUpdate = '/app_update';
}
