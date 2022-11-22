import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class HelpSettingsView extends StatelessWidget {
  const HelpSettingsView({Key? key}) : super(key: key);

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
                title: StringValues.help,
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
              /// Report an issue
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.eight),
                  topRight: Radius.circular(Dimens.eight),
                ),
                title: Text(
                  StringValues.reportIssue.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.reportIssueDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                onTap: RouteManagement.goToReportIssueSettingsView,
              ),

              Dimens.divider,

              /// Send us suggestions
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.sendUsSuggestions.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.sendUsSuggestionsDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                onTap: RouteManagement.goToSendSuggestionsSettingsView,
              ),

              Dimens.divider,

              /// Privacy Policy
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                title: Text(
                  StringValues.privacyPolicy.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.privacyPolicyDesc,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),

              Dimens.divider,

              /// Terms of Use
              NxListTile(
                padding: Dimens.edgeInsets16_12,
                bgColor: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                title: Text(
                  StringValues.termsOfUse.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                subtitle: Text(
                  StringValues.termsOfUseDesc,
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
