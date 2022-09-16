import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
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

  final _isLoading = false.obs;
  final _hasUpdate = false.obs;
  final _apkDownloadLink = ''.obs;
  final _latestVersion = ''.obs;
  final _version = ''.obs;
  final _buildNumber = ''.obs;
  final _changelog = ''.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get hasUpdate => _hasUpdate.value;

  String get apkDownloadLink => _apkDownloadLink.value;

  String get latestVersion => _latestVersion.value;

  String get version => _version.value;

  String get buildNumber => _buildNumber.value;

  String get changelog => _changelog.value;

  /// Setters
  set version(value) => _version.value = value;

  set buildNumber(value) => _buildNumber.value = value;

  set changelog(value) => _changelog.value = value;

  Future<void> _getPackageInfo() async {
    AppUtility.printLog("Getting package info...");
    var packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    AppUtility.printLog('version: $version');
    AppUtility.printLog('buildNumber: $buildNumber');
  }

  Future<void> _checkAppUpdate(bool showLoading, bool showAlert) async {
    await _getPackageInfo();

    AppUtility.printLog("Check App Update Request");

    _isLoading.value = true;
    update();

    if (showLoading) {
      AppUtility.showLoadingDialog();
    }

    try {
      final response = await _apiProvider.getLatestReleaseInfo();

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        String latestVersion = decodedData['tag_name'];

        if (latestVersion.contains('+')) {
          _latestVersion.value = latestVersion.substring(1);
          changelog = decodedData['body'];
          var splitLatestVer = latestVersion.substring(1).split('+');

          var latestBuildVersion = splitLatestVer[0];
          var latestBuildNumber = int.parse(splitLatestVer[1]);

          var splitLatestBuildVersion = latestBuildVersion.split('.');
          var latestBuildVer1 = int.parse(splitLatestBuildVersion[0]);
          var latestBuildVer2 = int.parse(splitLatestBuildVersion[1]);
          var latestBuildVer3 = int.parse(splitLatestBuildVersion[2]);

          final currentBuildVersion = version;
          final currentBuildNumber = int.parse(buildNumber);

          var splitCurrentBuildVersion = currentBuildVersion.split('.');
          var currentBuildVer1 = int.parse(splitCurrentBuildVersion[0]);
          var currentBuildVer2 = int.parse(splitCurrentBuildVersion[1]);
          var currentBuildVer3 = int.parse(splitCurrentBuildVersion[2]);

          if (latestBuildVer1 > currentBuildVer1) {
            _hasUpdate.value = true;
          } else if (latestBuildVer1 == currentBuildVer1) {
            if (latestBuildVer2 > currentBuildVer2) {
              _hasUpdate.value = true;
            } else if (latestBuildVer2 == currentBuildVer2) {
              if (latestBuildVer3 > currentBuildVer3) {
                _hasUpdate.value = true;
              } else if (latestBuildVer3 == currentBuildVer3) {
                if (latestBuildNumber > currentBuildNumber) {
                  _hasUpdate.value = true;
                } else {
                  _hasUpdate.value = false;
                }
              } else {
                _hasUpdate.value = false;
              }
            } else {
              _hasUpdate.value = false;
            }
          } else {
            _hasUpdate.value = false;
          }

          if (_hasUpdate.value == true) {
            AppUtility.printLog("Update found");
            List<dynamic> assets = decodedData['assets'];
            var apk = assets.singleWhere(
              (element) => element['name'] == 'app-release.apk',
            );

            if (apk != null) {
              _apkDownloadLink.value = apk['browser_download_url'];
              _isLoading.value = false;
              update();
              if (showLoading) {
                AppUtility.closeDialog();
              }
              RouteManagement.goToAppUpdateView();
            }
          } else {
            if (showLoading) {
              AppUtility.closeDialog();
            }
            _isLoading.value = false;
            update();
            if (showAlert) {
              AppUtility.showSnackBar('You have the latest version.', '');
            }
            AppUtility.printLog("No update found");
          }
        } else {
          _isLoading.value = false;
          update();
          if (showLoading) {
            AppUtility.closeDialog();
          }
          _hasUpdate.value = false;
          _apkDownloadLink.value = '';
          AppUtility.printLog("Bad format of release version");
        }
        AppUtility.printLog("Check App Update Success");
      } else {
        if (showLoading) {
          AppUtility.closeDialog();
        }
        _isLoading.value = false;
        update();
        AppUtility.printLog("Check App Update Error");
        AppUtility.printLog(decodedData);
      }
    } on SocketException {
      if (showLoading) {
        AppUtility.closeDialog();
      }
      _isLoading.value = false;
      update();
      AppUtility.printLog("Check App Update Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      if (showLoading) {
        AppUtility.closeDialog();
      }
      _isLoading.value = false;
      update();
      AppUtility.printLog("Check App Update Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      if (showLoading) {
        AppUtility.closeDialog();
      }
      _isLoading.value = false;
      update();
      AppUtility.printLog("Check App Update Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      if (showLoading) {
        AppUtility.closeDialog();
      }
      _isLoading.value = false;
      update();
      AppUtility.printLog("Check App Update Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _downloadAppUpdate() async {
    if (_apkDownloadLink.value.isEmpty || _apkDownloadLink.value == '') {
      AppUtility.showSnackBar(
        'App download link is invalid.',
        StringValues.warning,
      );
      return;
    }

    _isLoading.value = true;
    update();

    var id = await RUpgrade.upgrade(
      _apkDownloadLink.value,
      fileName: 'app-release.apk',
      isAutoRequestInstall: true,
      notificationStyle: NotificationStyle.none,
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
