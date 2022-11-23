import 'package:get/get.dart';
import 'package:social_media_app/modules/blue_tick_verification/blue_tick_verification_controller.dart';

class BlueTickVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BlueTickVerificationController.new);
  }
}
