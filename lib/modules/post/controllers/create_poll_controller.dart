import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class CreatePollController extends GetxController {
  static CreatePollController get find => Get.find();

  final _auth = AuthService.find;
  final _postController = PostController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _pollQuestion = ''.obs;
  final _pollOptionFields = <Widget>[].obs;
  final _pollOptions = <String>[].obs;
  final _pollLengthDays = 1.obs;
  final _pollLengthHours = 0.obs;
  final _pollLengthMinutes = 0.obs;
  final _pollVisibility = <String, dynamic>{}.obs;
  final _pollEndsAt = ''.obs;

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String get pollQuestion => _pollQuestion.value;

  List<Widget> get pollOptionFields => _pollOptionFields;

  List<String> get pollOptions => _pollOptions;

  int get pollLengthDays => _pollLengthDays.value;

  int get pollLengthHours => _pollLengthHours.value;

  int get pollLengthMinutes => _pollLengthMinutes.value;

  Map<String, dynamic> get pollVisibility => _pollVisibility;

  String get pollEndsAt => _pollEndsAt.value;

  void onChangePollQuestion(String value) {
    _pollQuestion.value = value;
    update();
  }

  void onChangePollOption(String value, int index) {
    _pollOptions[index] = value;
    update();
  }

  void onPostVisibilityChange(Map<String, dynamic> value) {
    _pollVisibility.value = value;
    update();
  }

  void onChangePollLengthDays(int value) {
    _pollLengthDays.value = value;
    if (_pollLengthDays.value == 0 &&
        _pollLengthHours.value == 0 &&
        _pollLengthMinutes.value == 0) {
      _pollLengthDays.value = 1;
    }
    if (_pollLengthDays.value >= 7) {
      _pollLengthHours.value = 0;
      _pollLengthMinutes.value = 0;
    }

    update();
  }

  String getDaysHoursMinutes() {
    var dayStr = '';
    var hourStr = '';
    var minuteStr = '';

    if (pollLengthDays > 0) {
      if (pollLengthDays == 1) {
        dayStr = '$pollLengthDays ${StringValues.day}';
      } else {
        dayStr = '$pollLengthDays ${StringValues.days}';
      }

      if (pollLengthHours > 0) {
        if (pollLengthHours == 1) {
          hourStr = '$pollLengthHours ${StringValues.hour}';
        } else {
          hourStr = '$pollLengthHours ${StringValues.hours}';
        }
      }

      if (pollLengthMinutes > 0) {
        if (pollLengthMinutes == 1) {
          minuteStr = '$pollLengthMinutes ${StringValues.minute}';
        } else {
          minuteStr = '$pollLengthMinutes ${StringValues.minutes}';
        }
      }

      return '$dayStr $hourStr $minuteStr';
    } else if (pollLengthHours > 0) {
      if (pollLengthHours == 1) {
        hourStr = '$pollLengthHours ${StringValues.hour}';
      } else {
        hourStr = '$pollLengthHours ${StringValues.hours}';
      }

      if (pollLengthMinutes > 0) {
        if (pollLengthMinutes == 1) {
          minuteStr = '$pollLengthMinutes ${StringValues.minute}';
        } else {
          minuteStr = '$pollLengthMinutes ${StringValues.minutes}';
        }
      }

      return '$hourStr $minuteStr';
    } else {
      if (pollLengthMinutes == 1) {
        minuteStr = '$pollLengthMinutes ${StringValues.minute}';
      } else {
        minuteStr = '$pollLengthMinutes ${StringValues.minutes}';
      }

      return '$minuteStr';
    }
  }

  void onChangePollLengthHours(int value) {
    if (_pollLengthDays.value >= 7) return;
    _pollLengthHours.value = value;

    _pollEndsAt.value = DateTime.now()
        .add(Duration(
          days: _pollLengthDays.value > 0 ? _pollLengthDays.value : 0,
          hours: _pollLengthHours.value > 0 ? _pollLengthHours.value : 0,
          minutes: _pollLengthMinutes.value > 0 ? _pollLengthMinutes.value : 0,
        ))
        .toIso8601String();

    AppUtility.log(
        'pollEndsAt: ${DateTime.parse(_pollEndsAt.value).getPollDurationLeft()}');
    AppUtility.log('pollEndsAt: ${_pollEndsAt.value}');
    update();
  }

  void onChangePollLengthMinutes(int value) {
    if (_pollLengthDays.value >= 7) return;
    _pollLengthMinutes.value = value;

    _pollEndsAt.value = DateTime.now()
        .add(Duration(
          days: _pollLengthDays.value > 0 ? _pollLengthDays.value : 0,
          hours: _pollLengthHours.value > 0 ? _pollLengthHours.value : 0,
          minutes: _pollLengthMinutes.value > 0 ? _pollLengthMinutes.value : 0,
        ))
        .toIso8601String();

    AppUtility.log(
        'pollEndsAt: ${DateTime.parse(_pollEndsAt.value).getPollDurationLeft()}');
    AppUtility.log('pollEndsAt: ${_pollEndsAt.value}');
    update();
  }

  Padding _buildOptionField(BuildContext context, int index) {
    _pollOptions.insert(index, '');
    return Padding(
      padding: Dimens.edgeInsetsOnlyBottom4,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: '${StringValues.option} ${index + 1}',
          suffix: GetBuilder<CreatePollController>(
            builder: (logic) => Text(
              logic.pollOptions[index].length.toString(),
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(context).textTheme.titleSmall!.color,
              ),
            ),
          ),
        ),
        style: AppStyles.style14Normal.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        minLines: 1,
        maxLines: 1,
        maxLength: 30,
        buildCounter: (context,
            {currentLength = 0, isFocused = false, maxLength}) {
          return Dimens.shrinkedBox;
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) => onChangePollOption(value, index),
      ),
    );
  }

  void addPollOption(BuildContext context) {
    if (_pollOptionFields.length >= 4) return;
    var option = _buildOptionField(context, _pollOptionFields.length);
    _pollOptionFields.add(option);
    update();
  }

  @override
  onInit() {
    super.onInit();
    _pollVisibility.value = {'id': 'public', 'title': 'Public'};
    _pollOptionFields
        .add(_buildOptionField(Get.context!, _pollOptionFields.length));
    _pollOptionFields
        .add(_buildOptionField(Get.context!, _pollOptionFields.length));
  }

  void goToPollPreviewPage() {
    if (_pollQuestion.value.isEmpty) {
      AppUtility.showSnackBar(
          StringValues.enterPollQuestion, StringValues.warning);
      return;
    }

    if (_pollOptions.length < 2) {
      AppUtility.showSnackBar(
          StringValues.enterAtleastTwoOptions, StringValues.warning);
      return;
    }

    for (var option in _pollOptions) {
      if (option.isEmpty) {
        AppUtility.showSnackBar(
            StringValues.pollOptionEmptyError, StringValues.warning);
        return;
      }
    }

    _pollEndsAt.value = DateTime.now()
        .add(Duration(
          days: _pollLengthDays.value > 0 ? _pollLengthDays.value : 0,
          hours: _pollLengthHours.value > 0 ? _pollLengthHours.value : 0,
          minutes: _pollLengthMinutes.value > 0 ? _pollLengthMinutes.value : 0,
        ))
        .toLocal()
        .toUtc()
        .toIso8601String();

    RouteManagement.goToPollPreviewView();
  }

  Future<void> _createNewPoll() async {
    if (_pollQuestion.value.isEmpty) {
      AppUtility.showSnackBar(
          StringValues.enterPollQuestion, StringValues.warning);
      return;
    }

    if (_pollOptions.length < 2) {
      AppUtility.showSnackBar(
          StringValues.enterAtleastTwoOptions, StringValues.warning);
      return;
    }

    for (var option in _pollOptions) {
      if (option.isEmpty) {
        AppUtility.showSnackBar(
            StringValues.pollOptionEmptyError, StringValues.warning);
        return;
      }
    }

    var pollEndsAt = DateTime.now()
        .add(Duration(
          days: _pollLengthDays.value > 0 ? _pollLengthDays.value : 0,
          hours: _pollLengthHours.value > 0 ? _pollLengthHours.value : 0,
          minutes: _pollLengthMinutes.value > 0 ? _pollLengthMinutes.value : 0,
        ))
        .toLocal()
        .toUtc()
        .toIso8601String();

    AppUtility.log(
        'pollEndsAt: ${DateTime.parse(_pollEndsAt.value).getPollDurationLeft()}');
    AppUtility.log('pollEndsAt: ${_pollEndsAt.value}');

    AppUtility.showLoadingDialog();

    try {
      final body = {
        'pollQuestion': _pollQuestion.value,
        'pollOptions': _pollOptions,
        'pollEndsAt': pollEndsAt,
        'visibility': _pollVisibility['id']!,
      };

      final response = await _apiProvider.createPoll(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;

        _isLoading.value = false;
        update();

        _postController.postList.insert(0, Post.fromJson(decodedData['post']));
        _postController.update();
        await ProfileController.find.fetchProfileDetails(fetchPost: true);

        AppUtility.closeDialog();
        RouteManagement.goToHomeView();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> createNewPoll() async {
    await _createNewPoll();
  }
}
