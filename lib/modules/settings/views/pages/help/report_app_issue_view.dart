import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/file_image.dart';
import 'package:social_media_app/app_widgets/app_text_btn.dart';
import 'package:social_media_app/modules/settings/controllers/report_app_issue_controller.dart';

class ReportAppIssueView extends StatelessWidget {
  const ReportAppIssueView({Key? key}) : super(key: key);

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
                title: StringValues.reportIssue,
                padding: Dimens.edgeInsetsDefault,
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
      child: SingleChildScrollView(
          child: GetBuilder<ReportAppIssueController>(
        builder: (logic) => Padding(
          padding: Dimens.edgeInsets0_16,
          child: FocusScope(
            node: logic.focusNode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: Dimens.hundred,
                  constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      hintStyle: AppStyles.style14Normal.copyWith(
                        color: ColorValues.grayColor,
                      ),
                      hintText: StringValues.writeAboutIssue,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
                    ),
                    controller: logic.messageTextController,
                  ),
                ),
                if (logic.pickedFileList!.isNotEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dimens.boxHeight16,
                      Wrap(
                        children: logic.pickedFileList!
                            .map(
                              (e) => Stack(
                                children: [
                                  Padding(
                                    padding:
                                        Dimens.edgeInsetsOnlyBottom2.copyWith(
                                      bottom: Dimens.zero,
                                      right: Dimens.eight,
                                    ),
                                    child: NxFileImage(
                                      file: e,
                                      scale: 1.0,
                                      width: Dimens.sixtyFour,
                                      height: Dimens.sixtyFour,
                                    ),
                                  ),
                                  Positioned(
                                    top: Dimens.zero,
                                    right: Dimens.zero,
                                    child: GestureDetector(
                                      onTap: () => logic.removeImage(e),
                                      child: CircleAvatar(
                                        radius: Dimens.twelve,
                                        backgroundColor: ColorValues.errorColor,
                                        child: Icon(
                                          Icons.delete,
                                          color: ColorValues.whiteColor,
                                          size: Dimens.fourteen,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                if (logic.pickedFileList!.length < 10)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dimens.boxHeight16,
                      NxTextButton(
                        label: 'Add screenshots',
                        onTap: logic.selectMultipleFiles,
                      ),
                    ],
                  ),
                Dimens.boxHeight40,
                NxFilledButton(
                  onTap: logic.sendIssueReportOtp,
                  label: StringValues.next.toUpperCase(),
                  height: Dimens.fiftySix,
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      )),
    );
  }
}
