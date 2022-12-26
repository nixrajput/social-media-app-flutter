import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxAppBar(
                padding: Dimens.edgeInsetsDefault,
                title: StringValues.account,
              ),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var profile = ProfileController.find.profileDetails!.user!;
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Dimens.boxHeight8,

            /// Change Email Address
            NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              title: Text(
                StringValues.email.toTitleCase(),
                style: AppStyles.style14Bold,
              ),
              subtitle: Text(
                profile.email,
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              onTap: () => RouteManagement.goToVerifyPasswordView(
                RouteManagement.goToChangeEmailSettingsView,
              ),
            ),

            Dimens.boxHeight8,

            /// Add or Change Phone Number
            NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              title: Text(
                StringValues.phone.toTitleCase(),
                style: AppStyles.style14Bold,
              ),
              subtitle: Text(
                profile.phone != null
                    ? '${profile.countryCode} ${profile.phone}'
                    : StringValues.addPhoneNumber,
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              onTap: () => RouteManagement.goToVerifyPasswordView(
                RouteManagement.goToChangePhoneSettingsView,
              ),
            ),

            Dimens.boxHeight8,

            /// Change Username
            NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              title: Text(
                StringValues.username.toTitleCase(),
                style: AppStyles.style14Bold,
              ),
              subtitle: Text(
                profile.uname,
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              onTap: () => RouteManagement.goToVerifyPasswordView(
                RouteManagement.goToEditUsernameView,
              ),
            ),

            Dimens.boxHeight8,

            /// Apply for Blue Tick
            NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              title: Text(
                StringValues.verified.toTitleCase(),
                style: AppStyles.style14Bold,
              ),
              subtitle: Text(
                profile.isVerified ? StringValues.yes : StringValues.no,
                style: AppStyles.style13Normal.copyWith(
                  color: profile.isVerified
                      ? ColorValues.primaryColor
                      : Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              onTap: () {
                if (profile.isVerified) {
                  AppUtility.showBottomSheet(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dimens.boxHeight16,
                      Icon(
                        Icons.verified,
                        color: ColorValues.primaryColor,
                        size: Dimens.sixty,
                      ),
                      Dimens.boxHeight16,
                      Text(
                        StringValues.verifiedAccount,
                        style: AppStyles.style16Bold,
                      ),
                      Dimens.boxHeight8,
                      Text(
                        StringValues.verifiedAccountDesc,
                        style: AppStyles.style14Normal.copyWith(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight16,
                    ],
                  );
                  return;
                } else {
                  RouteManagement.goToVerificationSettingsView();
                }
              },
            ),

            Dimens.boxHeight8,

            /// Deactivate Account

            NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              title: Text(
                StringValues.deactivate.toTitleCase(),
                style: AppStyles.style14Bold.copyWith(
                  color: ColorValues.errorColor,
                ),
              ),
              subtitle: Text(
                StringValues.deactivateAccountHelp,
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              onTap: RouteManagement.goToDeactivateAccountSettingsView,
            ),

            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }
}
