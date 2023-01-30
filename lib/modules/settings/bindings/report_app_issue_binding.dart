import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/report_app_issue_controller.dart';

class ReportAppIssueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReportAppIssueController.new);
  }
}
