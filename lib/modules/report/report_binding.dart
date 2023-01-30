import 'package:get/get.dart';
import 'package:social_media_app/modules/report/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReportController.new);
  }
}
