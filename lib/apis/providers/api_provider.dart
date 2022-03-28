import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/models/responses/user_response.dart';
import 'package:social_media_app/constants/urls.dart';

part 'api_provider.g.dart';

@RestApi(baseUrl: AppUrls.baseUrl)
abstract class ApiProvider {
  factory ApiProvider(Dio dio, {String? baseUrl}) = _ApiProvider;

  @POST(AppUrls.loginEndpoint)
  Future<LoginResponse> login(
    @Body() Map<String, dynamic> body,
    @Header("content-type") contentType,
  );

  @POST(AppUrls.loginEndpoint)
  Future<CommonResponse> register(
    @Body() Map<String, dynamic> body,
    @Header("content-type") contentType,
  );

  @GET(AppUrls.profileDetailsEndpoint)
  Future<UserResponse> getProfileDetails(
    @Header("content-type") contentType,
    @Header("authorization") token,
  );

  @GET(AppUrls.getAllPostsEndpoint)
  Future<PostResponse> fetchAllPosts(
    @Header("content-type") contentType,
    @Header("authorization") token,
  );

  @GET('${AppUrls.likePostEndpoint}/{postId}')
  Future<CommonResponse> likeUnlikePost(
    @Header("content-type") contentType,
    @Header("authorization") token,
    @Path("postId") String postId,
  );
}
