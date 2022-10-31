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
    baseUrl ??= AppSecrets.awsServerUrl;
  }

  final http.Client _client;

  String? baseUrl;

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

    if (queryParams != null) {
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

  /// Server -------------------------------------------------------------------

  Future<ResponseData> checkServerHealth() async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.serverHealthEndpoint,
      method: 'GET',
      feature: 'Server Health',
    );

    return response;
  }

  /// Auth ---------------------------------------------------------------------

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

  Future<ResponseData> login(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.loginEndpoint,
      method: 'POST',
      feature: 'Login',
      body: body,
    );

    return response;
  }

  Future<ResponseData> register(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.registerEndpoint,
      method: 'POST',
      feature: 'Register',
      body: body,
    );

    return response;
  }

  Future<ResponseData> forgotPassword(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.forgotPasswordEndpoint,
      method: 'POST',
      feature: 'Forgot Password',
      body: body,
    );

    return response;
  }

  Future<ResponseData> resetPassword(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.resetPasswordEndpoint,
      method: 'POST',
      feature: 'Reset Password',
      body: body,
    );

    return response;
  }

  Future<ResponseData> sendVerifyAccountOtp(Map<String, dynamic> body) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.verifyAccountEndpoint,
      method: 'POST',
      feature: 'Send Verify Account OTP',
      body: body,
    );

    return response;
  }

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

  /// Location & Device Info ---------------------------------------------------

  Future<ResponseData> getLocationInfo() async {
    final response = await _catchAsyncApiError(
      baseUrl: AppUrls.locationUrl,
      endPoint: '',
      method: 'GET',
      feature: 'Location Info',
    );

    return response;
  }

  Future<ResponseData> saveDeviceInfo(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.saveLoginInfoEndpoint,
      method: 'POST',
      feature: 'Save Device Info',
      body: body,
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  Future<ResponseData> getDeviceInfo(String token) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.getLoginInfoEndpoint,
      method: 'GET',
      feature: 'Get Login Info',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  Future<ResponseData> deleteDeviceInfo(String token, String deviceId) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.deleteDeviceInfoEndpoint,
      method: 'DELETE',
      feature: 'Delete Device Info',
      headers: {"authorization": "Bearer $token"},
      queryParams: {'deviceId': deviceId},
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// User ---------------------------------------------------------------------

  Future<ResponseData> getProfileDetails(String token) async {
    final response = await _catchAsyncApiError(
      endPoint: AppUrls.profileDetailsEndpoint,
      method: 'GET',
      feature: 'Get Profile Details',
      headers: {"authorization": "Bearer $token"},
    );

    return response;
  }

  Future<http.Response> getPreKeyBundle(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.preKeyBundleEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> savePreKeyBundle(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.preKeyBundleEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getDeviceId(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.deviceIdEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> saveDeviceId(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.deviceIdEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> saveFcmToken(String token, String fcmToken) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.fcmTokenEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({
        "fcmToken": fcmToken,
      }),
    );

    return response;
  }

  Future<http.Response> uploadProfilePicture(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.uploadProfilePicEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> deleteProfilePicture(String token) async {
    final response = await _client.delete(
      Uri.parse('${baseUrl!}${AppUrls.deleteProfilePicEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> updateProfile(
      String token, Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.updateProfileEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> changePassword(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.changePasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendChangeEmailOtp(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.changeEmailEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> changeEmail(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.changeEmailEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendAddChangePhoneOtp(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.addChangePhoneEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> addChangePhone(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.addChangePhoneEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> verifyPassword(String token, String password) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.verifyPasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({"password": password}),
    );

    return response;
  }

  Future<http.Response> deactivateAccount(
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.deactivateAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendReactivateAccountOtp(
      Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.reactivateAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> reactivateAccount(Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.reactivateAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  /// Post ---------------------------------------------------------------------

  Future<http.Response> createPost(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.createPostEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

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

  Future<http.Response> getPostsByTag(String token,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getPostsByTagEndpoint}?page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

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

  Future<http.Response> getPostLikedUsers(String token, String postId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.getPostLikedUsersEndpoint}?id=$postId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

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

  /// Misc ---------------------------------------------------------------------

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

  Future<http.Response> getUserDetailsById(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.userDetailsEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getUserDetailsByUsername(
      String token, String username) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.userDetailsEndpoint}?username=$username'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getUserPosts(String token, String userId,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getUserPostsEndpoint}?id=$userId&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> checkUsername(String token, String uname) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.checkUsernameEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> changeUsername(String token, String uname) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.changeUsernameEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> getFollowers(String token, String userId,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getFollowersEndpoint}?id=$userId&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getFollowings(String token, String userId,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getFollowingEndpoint}?id=$userId&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getPostDetails(String token, String postId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.postEndpoint}?id=$postId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Search -------------------------------------------------------------------

  Future<http.Response> searchTag(String token, String text,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.searchTagEndpoint}?q=$text&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

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

  Future<http.Response> searchFollowers(
      String token, String userId, String text,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.searchFollowersEndpoint}?id=$userId&q=$text&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> searchFollowings(
      String token, String userId, String text,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.searchFollowingEndpoint}?id=$userId&q=$text&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// --------------------------------------------------------------------------

  /// Comment ------------------------------------------------------------------

  Future<http.Response> addComment(
      String token, String postId, String comment) async {
    final response = await _client.post(
      Uri.parse('${baseUrl! + AppUrls.addCommentEndpoint}?postId=$postId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'comment': comment}),
    );

    return response;
  }

  Future<http.Response> getComments(String token, String postId,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getCommentsEndpoint}?postId=$postId&page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> deleteComment(String token, String commentId) async {
    final response = await _client.delete(
      Uri.parse('${baseUrl! + AppUrls.deleteCommentEndpoint}?id=$commentId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> likeUnlikeComment(
      String token, String commentId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.likeCommentEndpoint}?id=$commentId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// Notification -------------------------------------------------------------

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

  /// App Update ---------------------------------------------------------------

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
