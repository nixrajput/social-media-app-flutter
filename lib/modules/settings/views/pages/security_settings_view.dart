import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class SecuritySettingsView extends StatelessWidget {
  const SecuritySettingsView({Key? key}) : super(key: key);

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
                title: StringValues.security,
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Padding(
          padding: Dimens.edgeInsets0_16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Change Password
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.eight),
                  topRight: Radius.circular(Dimens.eight),
                ),
                title: Text(
                  StringValues.changePassword,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.changePasswordDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                onTap: RouteManagement.goToChangePasswordView,
              ),

              Dimens.divider,

              /// Login Activity
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.loginActivity.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.loginActivityDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                onTap: RouteManagement.goToLoginActivityView,
              ),

              Dimens.divider,

              /// 2-FA
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                title: Text(
                  StringValues.twoFaAuth,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.no,
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
