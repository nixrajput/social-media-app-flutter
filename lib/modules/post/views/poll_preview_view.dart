import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_poll_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PollPreviewView extends StatelessWidget {
  const PollPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find.profileDetails!.user!;

    return UnFocusWidget(
      opaque: true,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(profile, context),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NxAppBar _buildAppBar(Profile profile, BuildContext context) {
    return NxAppBar(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            _buildNextBtn(context),
          ],
        ),
      ),
      padding: Dimens.edgeInsetsDefault,
    );
  }

  GestureDetector _buildNextBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => CreatePollController.find.createNewPoll(),
      child: Container(
        padding: Dimens.edgeInsets8_16,
        decoration: BoxDecoration(
          color: ColorValues.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Center(
          child: Text(
            StringValues.post,
            style: AppStyles.style15Bold.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: GetBuilder<CreatePollController>(
        builder: (logic) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPoll(context, logic),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPoll(BuildContext context, CreatePollController logic) {
    final profile = ProfileController.find.profileDetails!.user!;
    return Container(
      margin: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(Dimens.four),
        boxShadow: AppStyles.defaultShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(context, profile),
          Padding(
            padding: Dimens.edgeInsets8.copyWith(
              top: Dimens.zero,
              bottom: Dimens.zero,
            ),
            child: NxExpandableText(text: logic.pollQuestion),
          ),
          Dimens.boxHeight4,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: logic.pollOptions
                .map((option) => _buildPollOption(context, logic, option))
                .toList(),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_8,
            child: _buildPostTime(context),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_8,
            child: Text(
              '${DateTime.parse(logic.pollEndsAt).getPollDurationLeft()}',
              style: AppStyles.style13Normal.copyWith(
                color: ColorValues.primaryColor,
              ),
            ),
          ),
          Dimens.boxHeight8,
        ],
      ),
    );
  }

  Widget _buildPostHead(BuildContext context, Profile profile) => Padding(
        padding: Dimens.edgeInsets8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: RouteManagement.goToProfileView,
              child: AvatarWidget(
                avatar: profile.avatar,
                size: Dimens.twenty,
              ),
            ),
            Dimens.boxWidth8,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFullName(context, profile),
                  _buildUsername(context, profile),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildFullName(BuildContext context, Profile profile) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: '${profile.fname} ${profile.lname}',
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = RouteManagement.goToProfileView,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (profile.isVerified)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxWidth4,
                Icon(
                  Icons.verified,
                  color: ColorValues.primaryColor,
                  size: Dimens.sixTeen,
                ),
              ],
            ),
        ],
      );

  Widget _buildPostTime(BuildContext context) {
    return Text(
      DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now().toLocal()),
      style: AppStyles.style12Normal.copyWith(
        color: Theme.of(context).textTheme.subtitle1!.color,
      ),
    );
  }

  Widget _buildUsername(BuildContext context, Profile profile) => RichText(
        text: TextSpan(
          text: profile.uname,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildPollOption(
      BuildContext context, CreatePollController logic, String option) {
    return Padding(
      padding: Dimens.edgeInsets4_8,
      child: Container(
        width: Dimens.screenWidth,
        padding: Dimens.edgeInsetsDefault,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.four),
          border: Border.all(
            color: ColorValues.linkColor,
            width: Dimens.one,
          ),
        ),
        child: Center(
          child: Text(
            option,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ),
    );
  }
}
