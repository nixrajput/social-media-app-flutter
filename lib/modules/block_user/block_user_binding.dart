import 'package:get/get.dart';
import 'package:social_media_app/modules/block_user/block_user_controller.dart';

class BlockUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BlockUserController.new);
  }
}
