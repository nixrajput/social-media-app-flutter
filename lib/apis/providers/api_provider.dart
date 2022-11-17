import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/exceptions.dart';
import 'package:social_media_app/utils/utility.dart';

class ResponseData {
  ResponseData({
    required this.data,
    required this.isSuccessful,
  });

  dynamic data;
  bool isSuccessful;
}

class ApiProvider {
  ApiProvider(this._client, {this.baseUrl}) {
    baseUrl ??= AppUrls.baseUrl;
  }

  final http.Client _client;

  String? baseUrl;

  /// This is the method that is called from the service class.
  Future<dynamic> _catchAsyncApiError({
    String? baseUrl,
    required String endPoint,
    required String method,
    required String feature,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    AppUtility.log('$feature Request');

    var url = Uri.parse((baseUrl ?? this.baseUrl!) + endPoint);

    if (queryParams != null && queryParams.isNotEmpty) {
      url = url.replace(queryParameters: queryParams);
    }

    AppUtility.log('URL: $url');

    var headersWithContentType = {
      "content-type": "application/json",
    };

    if (headers != null) {
      headersWithContentType.addAll(headers);
    }

    try {
      switch (method) {

        /// GET request
        case "GET":
          var response = await _client.get(
            url,
            headers: headersWithContentType,
          );

          var decodedData = jsonDecode(utf8.decode(response.bodyBytes));

          if (response.statusCode == 200 || response.statusCode == 201) {
            AppUtility.log('$feature Request Success');
            return ResponseData(data: decodedData, isSuccessful: true);
          } else {
            AppUtility.log('$feature Request Error', tag: 'error');
            AppUtility.log(
                'Error: ${response.statusCode} ${response.reasonPhrase} ${response.body}');
            return ResponseData(data: decodedData, isSuccessful: false);
          }

        /// POST request
        case "POST":
          var response = await _client.post(
            url,
            body: jsonEncode(body),
            headers: headersWithContentType,
          );

          var decodedData = jsonDecode(utf8.decode(response.bodyBytes));

          if (response.statusCode == 200 || response.statusCode == 201) {
            AppUtility.log('$feature Request Success');
            return ResponseData(data: decodedData, isSuccessful: true);
          } else {
            AppUtility.log('$feature Request Error', tag: 'error');
            AppUtility.log(
                'Error: ${response.statusCode} ${response.reasonPhrase} ${response.body}');
            return ResponseData(data: decodedData, isSuccessful: false);
          }

        /// PUT request
        case "PUT":
          var response = await _client.put(
            url,
            body: jsonEncode(body),
            headers: headersWithContentType,
          );

          var decodedData = jsonDecode(utf8.decode(response.bodyBytes));

          if (response.statusCode == 200 || response.statusCode == 201) {
            AppUtility.log('$feature Request Success');
            return ResponseData(data: decodedData, isSuccessful: true);
          } else {
            AppUtility.log('$feature Request Error', tag: 'error');
            AppUtility.log(
                'Error: ${response.statusCode} ${response.reasonPhrase} ${response.body}');
            return ResponseData(data: decodedData, isSuccessful: false);
          }

        /// DELETE request
        case "DELETE":
          var response = await _client.delete(
            url,
            headers: headersWithContentType,
          );

          var decodedData = jsonDecode(utf8.decode(response.bodyBytes));

          if (response.statusCode == 200 || response.statusCode == 201) {
            AppUtility.log('$feature Request Success');
            return ResponseData(data: decodedData, isSuccessful: true);
          } else {
            AppUtility.log('$feature Request Error', tag: 'error');
            AppUtility.log(
                'Error: ${response.statusCode} ${response.reasonPhrase} $decodedData');
            return ResponseData(data: decodedData, isSuccessful: false);
          }
      }
    } on SocketException {
      AppUtility.log('$feature Request Error', tag: 'error');
      AppUtility.log('Error: No Internet Connection', tag: 'error');
      throw AppException('No Internet Connection');
    } on TimeoutException {
      AppUtility.log('$feature Request Error', tag: 'error');
      AppUtility.log('Error: Request Timeout', tag: 'error');
      throw AppException('Request Timeout');
    } on FormatException catch (e) {
      AppUtility.log('$feature Request Error', tag: 'error');
      AppUtility.log('Format Exception: $e', tag: 'error');
      throw AppException('Format Exception: $e');
    } catch (exc) {
      AppUtility.log('$feature Request Error', tag: 'error');
      AppUtility.log('Error: $exc', tag: 'error');
      throw AppException(exc.toString());
    }
  }

  /// --------------------------------------------------------------------------

  /// Server -------------------------------------------------------------------

  /// Check Server Health
  Future<ResponseData> checkServerHealth() async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.serverHealthEndpoint,
      method: 'GET',
      feature: 'Server Health',
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Auth ---------------------------------------------------------------------

  /// Validate Token
  Future<ResponseData> validateToken(String token) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.validateTokenEndpoint,
      method: 'GET',
      feature: 'Validate Token',
      headers: {'authorization': 'Bearer $token'},
      queryParams: {'token': token},
    );

    return response;
  }

  /// Login
  Future<ResponseData> login(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.loginEndpoint,
      method: 'POST',
      feature: 'Login',
      body: body,
    );

    return response;
  }

  /// Register
  Future<ResponseData> register(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.registerEndpoint,
      method: 'POST',
      feature: 'Register',
      body: body,
    );

    return response;
  }

  /// Forgot Password
  Future<ResponseData> forgotPassword(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.forgotPasswordEndpoint,
      method: 'POST',
      feature: 'Forgot Password',
      body: body,
    );

    return response;
  }

  /// Reset Password
  Future<ResponseData> resetPassword(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.resetPasswordEndpoint,
      method: 'POST',
      feature: 'Reset Password',
      body: body,
    );

    return response;
  }

  /// Send Verify Account OTP
  Future<ResponseData> sendVerifyAccountOtp(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyAccountEndpoint,
      method: 'POST',
      feature: 'Send Verify Account OTP',
      body: body,
    );

    return response;
  }

  /// Verify Account
  Future<ResponseData> verifyAccount(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyAccountEndpoint,
      method: 'PUT',
      feature: 'Verify Account',
      body: body,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Login Info & Location ----------------------------------------------------

  /// Get Location Info From IP
  Future<ResponseData> getLocationInfoFromIp(String token, {String? ip}) async {
    var queryParameters = <String, dynamic>{};

    if (ip != null) {
      queryParameters['ip'] = ip;
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyLoginInfoEndpoint,
      method: 'GET',
      feature: 'Get Location Info From IP',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Save Login Info
  Future<ResponseData> saveLoginInfo(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.loginInfoEndpoint,
      method: 'POST',
      feature: 'Save Login Info',
      body: body,
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Get Login History
  Future<ResponseData> getLoginHistory(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getLoginHistoryEndpoint,
      method: 'GET',
      feature: 'Get Login History',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Login Info Details
  Future<ResponseData> getLoginInfoDetails(
      String token, String deviceId, String ip) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['deviceId'] = deviceId;
    queryParameters['ip'] = ip;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getLoginHistoryEndpoint,
      method: 'GET',
      feature: 'Get Login Info Details',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Delete Login Info
  Future<ResponseData> deleteLoginInfo(String token, String deviceId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.loginInfoEndpoint,
      method: 'DELETE',
      feature: 'Delete Device Info',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'deviceId': deviceId},
    );

    return response;
  }

  /// Verify Login Info & Session
  Future<ResponseData> verifyLoginInfo(String token, String deviceId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyLoginInfoEndpoint,
      method: 'GET',
      feature: 'Verify Login Info',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'deviceId': deviceId},
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// User ---------------------------------------------------------------------

  /// Get Profile Details
  Future<ResponseData> getProfileDetails(String token) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.profileDetailsEndpoint,
      method: 'GET',
      feature: 'Get Profile Details',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Upload Profile Picture
  Future<ResponseData> uploadProfilePicture(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.uploadProfilePicEndpoint,
      method: 'POST',
      body: body,
      feature: 'Upload Profile Picture',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Delete Profile Picture
  Future<ResponseData> deleteProfilePicture(String token) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.deleteProfilePicEndpoint,
      method: 'DELETE',
      feature: 'Delete Profile Picture',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Update Profile Details
  Future<ResponseData> updateProfile(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.updateProfileEndpoint,
      method: 'PUT',
      body: body,
      feature: 'Update Profile',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Change Password
  Future<ResponseData> changePassword(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.changePasswordEndpoint,
      method: 'POST',
      body: body,
      feature: 'Change Password',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Get PreKey Bundle
  Future<ResponseData> getPreKeyBundle(String token, String userId) async {
    var queryParameters = <String, dynamic>{};
    queryParameters['id'] = userId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.preKeyBundleEndpoint,
      method: 'GET',
      feature: 'Get Pre Key Bundle',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Save PreKey Bundle
  Future<ResponseData> savePreKeyBundle(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.preKeyBundleEndpoint,
      method: 'POST',
      body: body,
      feature: 'Save Pre Key Bundle',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Get FCM Token
  Future<ResponseData> getFcmToken(String token, String userId) async {
    var queryParameters = <String, dynamic>{};
    queryParameters['id'] = userId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.fcmTokenEndpoint,
      method: 'GET',
      feature: 'Get FCM Token',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Save FCM Token
  Future<ResponseData> saveFcmToken(String token, String fcmToken) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.fcmTokenEndpoint,
      method: 'POST',
      body: {"fcmToken": fcmToken},
      feature: 'Save FCM Token',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Send Email Change OTP
  Future<ResponseData> sendChangeEmailOtp(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.changeEmailEndpoint,
      method: 'POST',
      body: body,
      feature: 'Send Change Email OTP',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Change Profile Email
  Future<ResponseData> changeEmail(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.changeEmailEndpoint,
      method: 'PUT',
      body: body,
      feature: 'Change Email',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Send Phone Change OTP
  Future<ResponseData> sendAddChangePhoneOtp(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.addChangePhoneEndpoint,
      method: 'POST',
      body: body,
      feature: 'Send Add/Change Phone OTP',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Add/Change Phone
  Future<ResponseData> addChangePhone(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.addChangePhoneEndpoint,
      method: 'PUT',
      body: body,
      feature: 'Add/Change Phone',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Verify Password
  Future<ResponseData> verifyPassword(String token, String password) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyPasswordEndpoint,
      method: 'POST',
      body: {"password": password},
      feature: 'Verify Password',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Deactivate Account
  Future<ResponseData> deactivateAccount(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.deactivateAccountEndpoint,
      method: 'POST',
      body: body,
      feature: 'Deactivate Account',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Send Reactivate Account OTP
  Future<ResponseData> sendReactivateAccountOtp(
      Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reactivateAccountEndpoint,
      method: 'POST',
      body: body,
      feature: 'Send Reactivate Account OTP',
    );

    return response;
  }

  /// Reactivate Account
  Future<ResponseData> reactivateAccount(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reactivateAccountEndpoint,
      method: 'PUT',
      body: body,
      feature: 'Reactivate Account',
    );

    return response;
  }

  /// Request Blue Tick
  Future<ResponseData> requestBlueTick(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reportUserEndpoint,
      method: 'POST',
      feature: 'Report User',
      headers: {"authorization": "Bearer $token"},
      body: body,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Post ---------------------------------------------------------------------

  /// Create New Post
  Future<ResponseData> createPost(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.createPostEndpoint,
      method: 'POST',
      body: body,
      feature: 'Create Post',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  /// Get Posts in Feed
  Future<ResponseData> getPosts(String token, {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getPostsEndpoint,
      method: 'GET',
      feature: 'Get Posts',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Post Details
  Future<ResponseData> getPostDetails(String token, String postId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.postEndpoint,
      method: 'GET',
      feature: 'Get Post Details',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': postId},
    );

    return response;
  }

  /// Get Posts By Tag
  Future<ResponseData> getPostsByTag(String token, String tag,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['q'] = tag;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getPostsByTagEndpoint,
      method: 'GET',
      feature: 'Get Posts By Tag',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Like/Unlike Post
  Future<ResponseData> likeUnlikePost(String token, String postId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.likePostEndpoint,
      method: 'GET',
      feature: 'Like/Unlike Post',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': postId},
    );

    return response;
  }

  /// Get Post's Liked Users
  Future<ResponseData> getPostLikedUsers(String token, String postId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getPostLikedUsersEndpoint,
      method: 'GET',
      feature: 'Get Post Liked Users',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': postId},
    );

    return response;
  }

  /// Delete Post
  Future<ResponseData> deletePost(String token, String postId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.postEndpoint,
      method: 'DELETE',
      feature: 'Delete Post',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': postId},
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Misc ---------------------------------------------------------------------

  /// Get Trending Posts
  Future<ResponseData> getTrendingPosts(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getTrendingPostsEndpoint,
      method: 'GET',
      feature: 'Get Trending Posts',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Recommended Users
  Future<ResponseData> getRecommendedUsers(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getRecommendUsersEndpoint,
      method: 'GET',
      feature: 'Get Recommended Users',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get User Details By ID
  Future<ResponseData> getUserDetailsById(String token, String userId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.userDetailsEndpoint,
      method: 'GET',
      feature: 'Get User Details By Id',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': userId},
    );

    return response;
  }

  /// Get User Details By Username
  Future<ResponseData> getUserDetailsByUsername(
      String token, String username) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.userDetailsEndpoint,
      method: 'GET',
      feature: 'Get User Details By Username',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'username': username},
    );

    return response;
  }

  /// Get User's Posts
  Future<ResponseData> getUserPosts(String token, String userId,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getUserPostsEndpoint,
      method: 'GET',
      feature: 'Get User Posts',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Check Username Availability
  Future<ResponseData> checkUsername(String token, String uname) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.checkUsernameEndpoint,
      method: 'GET',
      feature: 'Check Username',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'username': uname},
    );

    return response;
  }

  /// Change Username
  Future<ResponseData> changeUsername(String token, String uname) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.changeUsernameEndpoint,
      method: 'POST',
      feature: 'Change Username',
      headers: {"authorization": "Bearer $token"},
      body: {'username': uname},
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Follower -----------------------------------------------------------------

  /// Follow/Unfollow User
  Future<ResponseData> followUnfollowUser(String token, String userId) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.followUserEndpoint,
      method: 'GET',
      feature: 'Follow/Unfollow User',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Cancel Follow Request
  Future<ResponseData> cancelFollowRequest(String token, String userId) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.cancelFollowRequestEndpoint,
      method: 'GET',
      feature: 'Cancel Follow Request',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Follow Requests
  Future<ResponseData> getFollowRequests(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getFollowRequests,
      method: 'GET',
      feature: 'Get Follow Requests',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Accept Follow Request
  Future<ResponseData> acceptFollowRequest(
      String token, String followRequestId) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = followRequestId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.acceptFollowRequestEndpoint,
      method: 'GET',
      feature: 'Accept Follow Request',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Remove Follow Request
  Future<ResponseData> removeFollowRequest(
      String token, String followRequestId) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = followRequestId;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.removeFollowRequestEndpoint,
      method: 'DELETE',
      feature: 'Remove Follow Request',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Followers
  Future<ResponseData> getFollowers(String token, String userId,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getFollowersEndpoint,
      method: 'GET',
      feature: 'Get Followers',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Followings
  Future<ResponseData> getFollowings(String token, String userId,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getFollowingEndpoint,
      method: 'GET',
      feature: 'Get Followings',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Search -------------------------------------------------------------------

  /// Search Tag
  Future<ResponseData> searchTag(String token, String text,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['q'] = text;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.searchTagEndpoint,
      method: 'GET',
      feature: 'Search Tag',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Search User
  Future<ResponseData> searchUser(String token, String text,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['q'] = text;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.searchUserEndpoint,
      method: 'GET',
      feature: 'Search User',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Search Posts
  Future<ResponseData> searchPosts(String token, String text,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['q'] = text;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.searchPostsEndpoint,
      method: 'GET',
      feature: 'Search Posts',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Search Followers
  Future<ResponseData> searchFollowers(String token, String userId, String text,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;
    queryParameters['q'] = text;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.searchFollowersEndpoint,
      method: 'GET',
      feature: 'Search Followers',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Search Followings
  Future<ResponseData> searchFollowings(
      String token, String userId, String text,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = userId;
    queryParameters['q'] = text;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.searchFollowingEndpoint,
      method: 'GET',
      feature: 'Search Followings',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Comment ------------------------------------------------------------------

  /// Add New Comment
  Future<ResponseData> addComment(
      String token, String postId, String comment) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.addCommentEndpoint,
      method: 'POST',
      feature: 'Add Comment',
      headers: {"authorization": "Bearer $token"},
      body: {'postId': postId, 'text': comment},
    );

    return response;
  }

  /// Get Comments
  Future<ResponseData> getComments(String token, String postId,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['postId'] = postId;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getCommentsEndpoint,
      method: 'GET',
      feature: 'Get Comments',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Delete Comment
  Future<ResponseData> deleteComment(String token, String commentId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.deleteCommentEndpoint,
      method: 'DELETE',
      feature: 'Delete Comment',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': commentId},
    );

    return response;
  }

  /// Like/Unlike Comment
  Future<ResponseData> likeUnlikeComment(String token, String commentId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.likeCommentEndpoint,
      method: 'GET',
      feature: 'Like Unlike Comment',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'id': commentId},
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Notification -------------------------------------------------------------

  /// Get Notifications
  Future<ResponseData> getNotifications(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getNotificationsEndpoint,
      method: 'GET',
      feature: 'Get Notifications',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Mark Notification As Read
  Future<ResponseData> markNotificationRead(String token, String id) async {
    var queryParameters = <String, dynamic>{};
    queryParameters['id'] = id;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.markNotificationsReadEndpoint,
      method: 'GET',
      feature: 'Mark Notification Read',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Delete Notification
  Future<ResponseData> deleteNotification(String token, String id) async {
    var queryParameters = <String, dynamic>{};
    queryParameters['id'] = id;

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.deleteNotificationsEndpoint,
      method: 'GET',
      feature: 'Delete Notification',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Chat ---------------------------------------------------------------------

  /// Get Last Messages
  Future<ResponseData> getAllLastMessages(String token,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getAllLastMessageEndpoint,
      method: 'GET',
      feature: 'Get Last Messages',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// Get Messages By User's ID
  Future<ResponseData> getMessagesById(String token, String id,
      {int? page, int? limit}) async {
    var queryParameters = <String, dynamic>{};

    queryParameters['id'] = id;

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }

    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getMessagesByIdEndpoint,
      method: 'GET',
      feature: 'Get Messages By Id',
      headers: {"authorization": "Bearer $token"},
      queryParams: queryParameters,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Report -------------------------------------------------------------------

  /// Report User
  Future<ResponseData> reportUser(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reportUserEndpoint,
      method: 'POST',
      feature: 'Report User',
      headers: {"authorization": "Bearer $token"},
      body: body,
    );

    return response;
  }

  /// Report Post
  Future<ResponseData> reportPost(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reportPostEndpoint,
      method: 'POST',
      feature: 'Report Post',
      headers: {"authorization": "Bearer $token"},
      body: body,
    );

    return response;
  }

  /// Report Comment
  Future<ResponseData> reportComment(
      String token, Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.reportCommentEndpoint,
      method: 'POST',
      feature: 'Report Comment',
      headers: {"authorization": "Bearer $token"},
      body: body,
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// App Update ---------------------------------------------------------------

  /// Get Latest App Release Info
  Future<ResponseData> getLatestReleaseInfo() async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.checkAppUpdateEndpoint,
      method: 'GET',
      feature: 'App Update',
      baseUrl: AppUrls.githubApiUrl,
      headers: {
        "authorization": "Bearer ${AppSecrets.githubToken}",
      },
    );

    return response;
  }
}

/// ----------------------------------------------------------------------------
