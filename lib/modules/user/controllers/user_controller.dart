import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/user_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class UserController extends GetxController {
  static UserController get find => Get.find();

  final _auth = AuthController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _userList = UserListResponse().obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  UserListResponse? get userList => _userList.value;

  set setUserListData(UserListResponse value) {
    _userList.value = value;
  }

  Future<void> _getUsers() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getUsers(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setUserListData = UserListResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      AppUtils.printLog('Get User List Error');
      AppUtils.printLog(err);
    }
  }

  Future<void> getUsers() async {
    await _getUsers();
  }

  @override
  void onInit() async {
    await _getUsers();
    super.onInit();
  }
}
