import 'package:get/get.dart';
import 'package:social_media_app/modules/report_issue/report_issue_controller.dart';

class ReportIssueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReportIssueController.new);
  }
}
