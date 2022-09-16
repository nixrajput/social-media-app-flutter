import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/send_suggestions_controller.dart';

class SendSuggestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SendSuggestionsController.new);
  }
}
