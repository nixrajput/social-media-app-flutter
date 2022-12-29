import 'dart:async';

import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class BannerController extends GetxController {
  static BannerController get find => Get.find();

  final profile = ProfileController.find;

  final _isLoading = false.obs;

  final List<String> _bannerList = [];

  bool get isLoading => _isLoading.value;

  List<String> get bannerList => _bannerList;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  _getData() async {
    // _bannerList.add(
    //   'Hello ${_profile.profileDetails.user!.fname}, thank you for being a '
    //   'valuable member of this platform. We have an important message for '
    //   'all users.',
    // );
    // _bannerList.add(
    //   'After releasing the production version, '
    //   'we may delete some of the data in the database for better and '
    //   'faster performance. Data will be deleted only if it is not '
    //   'required for the project or it may cause any issues or conflicts.',
    // );
  }

  // Future<void> _fetchBanners({int? page}) async {
  //   AppUtility.printLog("Fetching Banners Request");
  //   _isLoading.value = true;
  //   update();

  //   try {
  //     final response = await _apiProvider.getPosts(_auth.token, page: page);
  //     final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

  //     if (response.statusCode == 200) {
  //       // setPostData = PostResponse.fromJson(decodedData);
  //       // _postList.clear();
  //       // _postList.addAll(_postData.value.results!);
  //       _isLoading.value = false;
  //       update();
  //       AppUtility.printLog("Fetching Banners Success");
  //     } else {
  //       _isLoading.value = false;
  //       update();
  //       AppUtility.showSnackBar(
  //         decodedData[StringValues.message],
  //         StringValues.error,
  //       );
  //       AppUtility.printLog("Fetching Banners Error");
  //     }
  //   } on SocketException {
  //     _isLoading.value = false;
  //     update();
  //     AppUtility.printLog("Fetching Banners Error");
  //     AppUtility.printLog(StringValues.internetConnError);
  //     AppUtility.showSnackBar(
  //         StringValues.internetConnError, StringValues.error);
  //   } on TimeoutException {
  //     _isLoading.value = false;
  //     update();
  //     AppUtility.printLog("Fetching Banners Error");
  //     AppUtility.printLog(StringValues.connTimedOut);
  //     AppUtility.printLog(StringValues.connTimedOut);
  //     AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
  //   } on FormatException catch (e) {
  //     _isLoading.value = false;
  //     update();
  //     AppUtility.printLog("Fetching Banners Error");
  //     AppUtility.printLog(StringValues.formatExcError);
  //     AppUtility.printLog(e);
  //     AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
  //   } catch (exc) {
  //     _isLoading.value = false;
  //     update();
  //     AppUtility.printLog("Fetching Banners Error");
  //     AppUtility.printLog(StringValues.errorOccurred);
  //     AppUtility.printLog(exc);
  //     AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
  //   }
  // }

  Future<void> _deleteBanner(int index) async {
    if (index < 0) {
      return;
    }

    _bannerList.removeAt(index);
    update();
  }

  void deleteBanner(int index) async => await _deleteBanner(index);

// Future<void> fetchBanners() async => await _fetchBanners();
}
