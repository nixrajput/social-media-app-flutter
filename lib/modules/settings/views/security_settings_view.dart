import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/custom_list_tile.dart';
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
                padding: Dimens.edgeInsetsDefault,
              ),
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
          padding: Dimens.edgeInsetsHorizDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Dimens.boxHeight8,

              /// Change Password
              NxListTile(
                padding: Dimens.edgeInsets12,
                bgColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimens.four),
                title: Text(
                  StringValues.changePassword,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.changePasswordDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                onTap: RouteManagement.goToChangePasswordView,
              ),

              Dimens.boxHeight8,

              /// Login Activity
              NxListTile(
                padding: Dimens.edgeInsets12,
                bgColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimens.four),
                title: Text(
                  StringValues.loginActivity.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.loginActivityDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                onTap: RouteManagement.goToLoginActivityView,
              ),

              Dimens.boxHeight8,

              /// 2-FA
              NxListTile(
                padding: Dimens.edgeInsets12,
                bgColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimens.four),
                title: Text(
                  StringValues.twoFaAuth,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.no,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
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
