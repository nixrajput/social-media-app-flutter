part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = _Routes.splash;
  static const welcome = _Routes.welcome;
  static const error = _Routes.error;
  static const home = _Routes.home;

  static const login = _Routes.login;
  static const register = _Routes.register;

  static const settings = _Routes.settings;
  static const accountSettings = _Routes.accountSettings;
  static const securitySettings = _Routes.securitySettings;
  static const privacySettings = _Routes.privacySettings;
  static const helpSettings = _Routes.helpSettings;
  static const aboutSettings = _Routes.aboutSettings;
  static const themeSettings = _Routes.themeSettings;

  static const loginActivitySettings = _Routes.loginActivitySettings;
  static const accountPrivacySettings = _Routes.accountPrivacySettings;
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

  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const changePassword = _Routes.changePassword;
  static const sendVerifyAccountOtp = _Routes.sendVerifyAccountOtp;
  static const verifyAccount = _Routes.verifyAccount;
  static const sendVerifyEmailOtp = _Routes.sendVerifyEmailOtp;
  static const verifyEmail = _Routes.verifyEmail;

  static const editProfile = _Routes.editProfile;
  static const editName = _Routes.editName;
  static const editUsername = _Routes.editUsername;
  static const editAbout = _Routes.editAbout;
  static const editDob = _Routes.editDob;
  static const editGender = _Routes.editGender;
  static const editPhone = _Routes.editPhone;
  static const following = _Routes.following;
  static const followers = _Routes.followers;

  static const createPost = _Routes.createPost;
  static const addCaption = _Routes.addCaption;
  static const postDetails = _Routes.postDetails;
  static const postMediaView = _Routes.postMediaView;
  static const comments = _Routes.comments;
  static const postLikedUsers = _Routes.postLikedUsers;

  static const userProfile = _Routes.userProfile;

  static const appUpdate = _Routes.appUpdate;
}

abstract class _Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const error = '/error';
  static const home = '/home';

  static const login = '/login';
  static const register = '/register';

  static const settings = '/settings';
  static const accountSettings = "/account_settings";
  static const securitySettings = "/security_settings";
  static const privacySettings = "/privacy_settings";
  static const helpSettings = "/help_settings";
  static const aboutSettings = "/about_settings";
  static const themeSettings = "/theme_settings";

  static const accountPrivacySettings = '/account_privacy_settings';
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

  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const changePassword = '/change_password';
  static const sendVerifyAccountOtp = '/send_account_verification_otp';
  static const verifyAccount = '/verify_account';
  static const sendVerifyEmailOtp = '/send_email_verification_otp';
  static const verifyEmail = '/verify_email';

  static const editProfile = '/edit_profile';
  static const editName = '/edit_name';
  static const editUsername = '/edit_username';
  static const editAbout = '/edit_about';
  static const editDob = '/edit_dob';
  static const editGender = '/edit_gender';
  static const editPhone = '/edit_phone';
  static const following = '/following';
  static const followers = '/followers';

  static const createPost = '/create_post';
  static const addCaption = '/add-caption';
  static const postDetails = '/post_details';
  static const postMediaView = '/post_media_view';
  static const comments = '/comments';
  static const postLikedUsers = '/post_liked_users';

  static const userProfile = '/user_profile';

  static const appUpdate = '/app_update';
}
