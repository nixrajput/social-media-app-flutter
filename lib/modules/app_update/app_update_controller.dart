import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:social_media_app/apis/models/entities/update_info.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

enum UpgradeMethod {
  all,
  hot,
  increment,
}

class AppUpdateController extends GetxController {
  static AppUpdateController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());
  final _authService = AuthService.find;

  final _isLoading = false.obs;
  final _hasUpdate = false.obs;
  final _version = ''.obs;
  final _buildNumber = ''.obs;
  final _updateInfo = UpdateInfo().obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get hasUpdate => _hasUpdate.value;

  String get version => _version.value;

  String get buildNumber => _buildNumber.value;

  UpdateInfo get updateInfo => _updateInfo.value;

  /// Setters
  set version(value) => _version.value = value;
  set buildNumber(value) => _buildNumber.value = value;
  set updateInfo(value) => _updateInfo.value = value;

  Future<void> init() async {
    await _checkAppUpdate(false, false);
  }

  Future<void> _getPackageInfo() async {
    AppUtility.log("Getting package info...");
    var packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  Future<void> _checkAppUpdate(bool showLoading, bool showAlert) async {
    await _getPackageInfo();

    var currentVersion = '$version+$buildNumber';

    _isLoading.value = true;
    update();

    if (showLoading) {
      AppUtility.showLoadingDialog();
    }

    try {
      final response = await _apiProvider.checkAppUpdate(currentVersion);

      if (response.isSuccessful) {
        var decodedData = response.data;
        AppUtility.log(decodedData[StringValues.message]);

        var isUpdateAvailable = decodedData['isUpdateAvailable'];

        if (showLoading) {
          AppUtility.closeDialog();
        }

        if (showAlert) {
          AppUtility.showSnackBar(
            decodedData[StringValues.message],
            StringValues.success,
          );
        }

        if (isUpdateAvailable == true) {
          _hasUpdate.value = true;

          if (_authService.token.isNotEmpty) {
            await _authService.logout();
          }
          updateInfo = UpdateInfo.fromJson(decodedData['data']);

          _isLoading.value = false;
          update();

          RouteManagement.goToAppUpdateView();
        }
      } else {
        var decodedData = response.data;
        if (showLoading) {
          AppUtility.closeDialog();
        }
        _isLoading.value = false;
        update();
        if (showAlert) {
          AppUtility.showSnackBar(
            decodedData[StringValues.message],
            StringValues.error,
          );
        }
        AppUtility.log(decodedData[StringValues.message]);
      }
    } catch (exc) {
      if (showLoading) {
        AppUtility.closeDialog();
      }
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar(exc.toString(), StringValues.error);
    }
  }

  Future<void> _downloadAppUpdate() async {
    if (updateInfo.downloadUrl!.isEmpty) {
      AppUtility.showSnackBar(
        'App download link is invalid.',
        StringValues.warning,
      );
      return;
    }

    _isLoading.value = true;
    update();

    var id = await RUpgrade.upgrade(
      updateInfo.downloadUrl!,
      fileName: updateInfo.fileName!,
      notificationStyle: NotificationStyle.none,
      installType: RUpgradeInstallType.normal,
      useDownloadManager: false,
    );

    final status = await RUpgrade.getDownloadStatus(id!);
    if (status == DownloadStatus.STATUS_SUCCESSFUL) {
      await RUpgrade.install(id);
      _isLoading.value = false;
      update();
    } else if (status == DownloadStatus.STATUS_FAILED) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar(
        'App download error.',
        StringValues.error,
      );
    }
  }

  String getStatus(DownloadStatus? status) {
    if (status == DownloadStatus.STATUS_FAILED) {
      return 'Failed';
    } else if (status == DownloadStatus.STATUS_PAUSED) {
      return 'Paused';
    } else if (status == DownloadStatus.STATUS_PENDING) {
      return 'Pending';
    } else if (status == DownloadStatus.STATUS_RUNNING) {
      return 'Downloading';
    } else if (status == DownloadStatus.STATUS_SUCCESSFUL) {
      return 'Successful';
    } else if (status == DownloadStatus.STATUS_CANCEL) {
      return 'Cancelled';
    } else {
      return 'Unknown';
    }
  }

  Future<void> checkAppUpdate(
          {bool showLoading = true, bool showAlert = true}) async =>
      await _checkAppUpdate(showLoading, showAlert);

  Future<void> downloadAppUpdate() async => await _downloadAppUpdate();

  void getPackageInfo() => _getPackageInfo();
}
