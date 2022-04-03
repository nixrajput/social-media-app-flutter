import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';

class ApiProvider {
  ApiProvider(this._client, {this.baseUrl}) {
    baseUrl ??= AppUrls.baseUrl;
  }

  final http.Client _client;

  String? baseUrl;

  Future<http.Response> login(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.loginEndpoint),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> register(Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.registerEndpoint),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> sendPasswordResetEmail(
      Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.forgotPasswordEndpoint),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> resetPassword(Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse(baseUrl! + AppUrls.resetPasswordEndpoint),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getProfileDetails(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.profileDetailsEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.StreamedResponse> createPost(
    String token,
    String? caption,
    List<http.MultipartFile> multiPartFiles,
  ) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl! + AppUrls.createPostEndpoint),
    );

    request.headers.addAll({
      'content-type': 'application/json',
      'authorization': 'Bearer $token',
    });

    request.files.addAll(multiPartFiles);
    if (caption != null) request.fields[StringValues.caption] = caption;

    final response = await request.send();

    return response;
  }

  Future<http.Response> fetchAllPosts(String token) async {
    final response = await _client.get(
      Uri.parse(baseUrl! + AppUrls.getFollowingPostsEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> likeUnlikePost(String token, String postId) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.likePostEndpoint}/$postId'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> deletePost(String token, String postId) async {
    final response = await _client.delete(
      Uri.parse('${baseUrl!}${AppUrls.postEndpoint}/$postId'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
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
      'content-type': 'application/json',
      'authorization': 'Bearer $token',
    });

    request.files.add(multiPartFile);

    final response = await request.send();

    return response;
  }

  Future<http.Response> updateProfileDetails(
      Map<String, dynamic> body, String token) async {
    final response = await _client.put(
      Uri.parse(baseUrl! + AppUrls.updateProfileDetailsEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> changePassword(
      Map<String, dynamic> body, String token) async {
    final response = await _client.put(
      Uri.parse(baseUrl! + AppUrls.updatePasswordEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> getUsers(String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.getUsersEndpoint}'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> followUnfollowUser(String userId, String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.followUserEndpoint}/$userId'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserDetails(String userId, String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.userDetailsEndpoint}/$userId'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> checkUsernameAvailability(
      String uname, String token) async {
    final response = await _client.post(
      Uri.parse(baseUrl! + AppUrls.checkUsernameAvailableEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> updateUsername(String uname, String token) async {
    final response = await _client.put(
      Uri.parse(baseUrl! + AppUrls.updateUsernameEndpoint),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode({'uname': uname}),
    );

    return response;
  }

  Future<http.Response> getFollowersList(String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.getFollowersEndpoint}'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getFollowingList(String token) async {
    final response = await _client.get(
      Uri.parse('${baseUrl!}${AppUrls.getFollowingEndpoint}'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
