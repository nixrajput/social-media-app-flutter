import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class VerifiedAccountSettingView extends StatelessWidget {
  const VerifiedAccountSettingView({super.key});

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
                  title: StringValues.blueTickVerification,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight16,
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: Dimens.edgeInsets0_16,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Blue Tick Image
            Icon(
              Icons.verified,
              size: Dimens.sixtyFour,
              color: ColorValues.primaryColor,
            ),

            Dimens.boxHeight16,

            /// Verification Text
            Text(
              StringValues.verification,
              style: AppStyles.style32Bold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),

            Dimens.boxHeight16,

            /// Verification Description

            Text(
              StringValues.verificationDescription,
              style: AppStyles.style16Normal,
            ),

            Dimens.boxHeight16,

            /// Verification Description

            Text(
              StringValues.verificationDescription2,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .color!
                    .withOpacity(0.5),
              ),
            ),

            Dimens.boxHeight32,

            /// Verification Process

            Text(
              StringValues.verificationProcessQuestionHelp,
              style: AppStyles.style20Bold,
            ),

            Text(
              StringValues.verificationProcessQuestionHelp2,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .color!
                    .withOpacity(0.5),
              ),
            ),

            Dimens.boxHeight16,

            Column(
              children: StringValues.verificationProcess
                  .map(
                    (item) => VerificationProcess(
                      index: item['index'].toString(),
                      title: item['title'].toString(),
                      description: item['desc'].toString(),
                    ),
                  )
                  .toList(),
            ),

            Dimens.boxHeight16,

            NxFilledButton(
              label: StringValues.applyForBlueTick.toTitleCase(),
              onTap: () {
                RouteManagement.goToBack();
                RouteManagement.goToBlueTickVerificationView();
              },
            ),

            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }
}

class VerificationProcess extends StatelessWidget {
  const VerificationProcess(
      {super.key,
      required this.index,
      required this.title,
      required this.description});

  final String index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets8_0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Verification Process Icon
          CircleAvatar(
            radius: Dimens.twentyFour,
            backgroundColor: Theme.of(context).textTheme.bodyText1!.color,
            child: Text(
              index,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),

          Dimens.boxWidth16,

          /// Verification Process Text
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppStyles.style18Bold,
                ),
                Dimens.boxHeight4,
                Text(
                  description,
                  style: AppStyles.style16Normal.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .color!
                        .withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
