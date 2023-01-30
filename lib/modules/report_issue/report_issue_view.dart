import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/report_issue/report_issue_controller.dart';

class ReportIssueView extends StatelessWidget {
  const ReportIssueView({super.key});

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<ReportIssueController>(
          builder: (logic) => Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: FocusScope(
              node: logic.focusNode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Dimens.boxHeight12,
                  _buildReportHelpText(context),
                  Dimens.boxHeight4,
                  _buildReportHelpTextDesc(context),
                  Dimens.boxHeight12,
                  _buildReasonTiles(context),
                  Dimens.boxHeight12,
                  _buildActionBtn(logic),
                  Dimens.boxHeight12,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  NxFilledButton _buildActionBtn(ReportIssueController logic) {
    return NxFilledButton(
      onTap: () => logic.updateAbout(),
      label: StringValues.submit.toUpperCase(),
      height: Dimens.fiftySix,
    );
  }

  Text _buildReportHelpTextDesc(BuildContext context) {
    return Text(
      StringValues.whyAreYouReportingThisDesc,
      style: AppStyles.style13Normal.copyWith(
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
    );
  }

  Text _buildReportHelpText(BuildContext context) {
    return Text(
      StringValues.whyAreYouReportingThis,
      style: AppStyles.style14Bold,
    );
  }

  ListView _buildReasonTiles(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: StringValues.reportReasons.length,
      itemBuilder: (context, index) {
        var reason = StringValues.reportReasons[index];
        return NxListTile(
          showBorder: false,
          bgColor: ColorValues.transparent,
          title: Text(
            reason,
            style: AppStyles.style14Bold,
          ),
          //onTap: () => logic.updateReason(reason),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.report,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
