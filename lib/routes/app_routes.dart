part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = _Routes.splash;
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

  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const changePassword = _Routes.changePassword;

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
  static const postDetails = _Routes.postDetails;

  static const userProfile = _Routes.userProfile;
}

abstract class _Routes {
  static const splash = '/';
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

  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const changePassword = '/change_password';

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
  static const postDetails = '/post_details';

  static const userProfile = '/user_profile';
}
