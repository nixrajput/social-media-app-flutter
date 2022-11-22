import 'package:get/get.dart';
import 'package:social_media_app/modules/verify-otp/controllers/verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(VerifyOtpController.new);
  }
}
