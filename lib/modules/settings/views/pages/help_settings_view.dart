import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class HelpSettingsView extends StatelessWidget {
  const HelpSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NxAppBar(
                title: StringValues.help,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight16,
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Report an issue

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.eight),
                  topRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.report_problem_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.reportIssue,
                  style: AppStyles.style14Bold,
                ),
                onTap: RouteManagement.goToReportIssueSettingsView,
              ),

              Dimens.divider,

              /// Send us suggestions

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.attach_email_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.sendUsSuggestions,
                  style: AppStyles.style14Bold,
                ),
              ),

              Dimens.divider,

              /// Privacy Policy

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.policy_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.privacyPolicy,
                  style: AppStyles.style14Bold,
                ),
              ),

              Dimens.divider,

              /// Terms of Use

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.info_outline,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.termsOfUse,
                  style: AppStyles.style14Bold,
                ),
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      ),
    );
  }
}
