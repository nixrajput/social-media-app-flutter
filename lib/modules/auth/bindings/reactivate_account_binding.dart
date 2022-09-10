import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/controllers/reactivate_account_controller.dart';

class ReactivateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReactivateAccountController.new);
  }
}
