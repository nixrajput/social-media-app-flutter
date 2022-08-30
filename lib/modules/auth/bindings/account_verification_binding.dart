import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/controllers/account_verification_controller.dart';

class AccountVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AccountVerificationController.new);
  }
}
