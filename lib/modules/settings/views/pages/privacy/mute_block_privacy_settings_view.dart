import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class MuteBlockPrivacySettingsView extends StatelessWidget {
  const MuteBlockPrivacySettingsView({Key? key}) : super(key: key);

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
                title: StringValues.muteAndBlock,
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
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimens.boxHeight8,

              /// Blocked Users
              NxListTile(
                padding: Dimens.edgeInsets12,
                bgColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimens.four),
                title: Text(
                  StringValues.blockedUsers,
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.blockedUsersDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                onTap: RouteManagement.goToBlockedUsersSettingsView,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
