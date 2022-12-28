import 'package:get/get.dart';
import 'package:social_media_app/modules/verification/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(VerificationController.new);
  }
}
