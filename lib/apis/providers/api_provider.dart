import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/urls.dart';

class ApiProvider {
  ApiProvider(this._client, {this.baseUrl}) {
    baseUrl ??= AppUrls.baseUrl;
  }

  final http.Client _client;

  String? baseUrl;

  /// Auth ---------------------------------------------------------------------

  Future<http.Response> login(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.loginEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> register(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.registerEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> forgotPassword(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.forgotPasswordEndpoint),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> resetPassword(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.resetPasswordEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendVerifyAccountOtp(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${baseUrl!}${AppUrls.verifyAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> verifyAccount(Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('${baseUrl!}${AppUrls.verifyAccountEndpoint}'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  /// Location Info ------------------------------------------------------------

  Future<http.Response> getLocationInfo() async {
    final response = await _client.get(
      Uri.parse(AppUrls.locationUrl),
      headers: {
        "content-type": "application/json",
      },
    );

    return response;
  }

  /// User ---------------------------------------------------------------------

  Future<http.Response> getProfileDetails(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.profileDetailsEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.StreamedResponse> uploadProfilePicture(
    String token,
    http.MultipartFile multiPartFile,
  ) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl! + AppUrls.uploadProfilePicEndpoint),
    );

    request.headers.addAll({
      "content-type": "application/json",
      "authorization": "Bearer $token",
    });

    request.files.add(multiPartFile);

    final response = await request.send();

    return response;
  }

  Future<http.Response> deleteProfilePicture(String token) async {
    final response = await _client.delete(
      Uri.parse(baseUrl! + AppUrls.deleteProfilePicEndpoint),
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
      Uri.parse(baseUrl! + AppUrls.updateProfileEndpoint),
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
      Uri.parse(baseUrl! + AppUrls.changePasswordEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendEmailVerificationOtp(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.verifyEmailEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> verifyEmail(String token, String otp) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.verifyEmailEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'otp': otp}),
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

  Future<http.Response> getPosts(String token, {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getPostsEndpoint}?page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> likeUnlikePost(String token, String postId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.likePostEndpoint}?id=$postId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
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

  Future<http.Response> deletePost(String token, String postId) async {
    final response = await _client.delete(
      Uri.parse('${baseUrl!}${AppUrls.postEndpoint}?id=$postId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// Misc ---------------------------------------------------------------------

  Future<http.Response> getRecommendedUsers(String token,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getRecommendUsersEndpoint}?page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> followUnfollowUser(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.followUserEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> cancelFollowRequest(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.cancelFollowRequestEndpoint}?id=$userId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getFollowRequests(String token,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.getFollowRequests}?page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> acceptFollowRequest(
      String token, String notificationId) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl! + AppUrls.acceptFollowRequestEndpoint}?id=$notificationId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> removeFollowRequest(
      String token, String notificationId) async {
    final response = await _client.delete(
      Uri.parse(
          '${baseUrl! + AppUrls.removeFollowRequestEndpoint}?id=$notificationId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getUserDetails(String token, String userId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl! + AppUrls.userDetailsEndpoint}?id=$userId'),
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

  Future<http.Response> getNotifications(String token,
      {int? page, int? limit}) async {
    final response = await _client.get(
      Uri.parse(
          '${baseUrl!}${AppUrls.getNotificationsEndpoint}?page=$page&limit=$limit'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> markNotificationRead(String token, String id) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.markNotificationsReadEndpoint}?id=$id'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// Device Info --------------------------------------------------------------

  Future<http.Response> saveDeviceInfo(
      String token, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.saveLoginInfoEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getDeviceInfo(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.getLoginInfoEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> deleteDeviceInfo(String token, String deviceId) async {
    final response = await _client.delete(
      Uri.parse(
          '${baseUrl! + AppUrls.deleteDeviceInfoEndpoint}?deviceId=$deviceId'),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
    );

    return response;
  }

  /// App Update ---------------------------------------------------------------

  Future<http.Response> getLatestReleaseInfo() async {
    final response = await _client.get(
      Uri.parse(AppUrls.githubApiUrl + AppUrls.checkAppUpdateEndpoint),
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer ${AppSecrets.githubToken}",
      },
    );

    return response;
  }
}
