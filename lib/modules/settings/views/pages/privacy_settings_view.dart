import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PrivacySettingsView extends StatelessWidget {
  const PrivacySettingsView({Key? key}) : super(key: key);

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
                title: StringValues.privacy,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight16,
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Account Privacy
              GetBuilder<ProfileController>(
                builder: (logic) => NxListTile(
                  padding: Dimens.edgeInsets16_12,
                  bgColor: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.eight),
                    topRight: Radius.circular(Dimens.eight),
                  ),
                  title: Text(
                    StringValues.accountPrivacy,
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    logic.profileDetails!.user!.isPrivate
                        ? StringValues.on
                        : StringValues.off,
                    style: AppStyles.style13Normal.copyWith(
                      color: logic.profileDetails!.user!.isPrivate
                          ? ColorValues.successColor
                          : Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
                  onTap: RouteManagement.goToChangeAccountPrivacyView,
                ),
              ),

              Dimens.divider,

              /// Online Status
              GetBuilder<ProfileController>(builder: (logic) {
                return NxListTile(
                  padding: Dimens.edgeInsets16_12,
                  bgColor: Theme.of(context).dialogBackgroundColor,
                  title: Text(
                    StringValues.onlineStatus,
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    logic.profileDetails!.user!.showOnlineStatus == true
                        ? StringValues.on
                        : StringValues.off,
                    style: AppStyles.style13Normal.copyWith(
                      color: logic.profileDetails!.user!.isPrivate
                          ? ColorValues.successColor
                          : Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
                  trailing: GetBuilder<ProfileController>(
                    builder: (logic) {
                      return Switch(
                        value: logic.profileDetails!.user!.showOnlineStatus ??
                            true,
                        onChanged: (value) {
                          var body = {'showOnlineStatus': '$value'};
                          logic.updateProfile(body);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    },
                  ),
                );
              }),

              Dimens.divider,

              /// Posts
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.postPrivacy,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.postPrivacyDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),

              Dimens.divider,

              /// Comments
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.commentPrivacy,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.commentPrivacyDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),

              Dimens.divider,

              /// Messages
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.messagePrivacy,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.commentPrivacyDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),

              Dimens.divider,

              /// Moments
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                title: Text(
                  StringValues.storyPrivacy,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.storyPrivacyDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
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
