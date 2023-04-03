import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/custom_radio_tile.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/report/report_controller.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<ReportController>(
          builder: (logic) => Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Dimens.boxHeight12,
                _buildReportHelpText(context),
                Dimens.boxHeight4,
                _buildReportHelpTextDesc(context),
                Dimens.boxHeight12,
                _buildReasonTiles(context, logic),
                Dimens.boxHeight12,
              ],
            ),
          ),
        ),
      ),
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

  ListView _buildReasonTiles(BuildContext context, ReportController logic) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: StringValues.reportReasons.length,
      itemBuilder: (context, index) {
        var reason = StringValues.reportReasons[index];
        return NxRadioTile(
          showBorder: false,
          bgColor: Theme.of(context).cardColor,
          margin: Dimens.edgeInsetsOnlyBottom12,
          padding: Dimens.edgeInsetsDefault,
          borderRadius: BorderRadius.circular(Dimens.four),
          title: Text(
            reason,
            style: AppStyles.style13Bold,
          ),
          value: reason,
          groupValue: logic.reason,
          onChanged: (value) => logic.updateReason(reason),
          onTap: () => logic.updateReason(reason),
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
                _buildAppBar(),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NxAppBar _buildAppBar() {
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      child: Expanded(
        child: Row(
          children: [
            Text(
              StringValues.report,
              style: AppStyles.style20Bold,
            ),
            const Spacer(),
            NxFilledButton(
              onTap: () => ReportController.find.submitReport(),
              label: StringValues.submit.toUpperCase(),
              labelStyle: AppStyles.style13Bold,
              padding: Dimens.edgeInsetsDefault,
            )
          ],
        ),
      ),
    );
  }
}
