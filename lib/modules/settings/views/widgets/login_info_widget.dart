import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/login_info.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/settings/controllers/login_info_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginInfoWidget extends StatelessWidget {
  const LoginInfoWidget({
    Key? key,
    required this.item,
    this.margin,
  }) : super(key: key);

  final LoginInfo item;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialog(item.deviceId!),
      child: Padding(
        padding: margin ?? Dimens.edgeInsets8_0,
        child: NxListTile(
          padding: Dimens.edgeInsets12,
          bgColor: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.four)),
          leading: item.deviceType == 'android'
              ? CircleAvatar(
                  backgroundColor: ColorValues.grayColor,
                  radius: Dimens.twentyFour,
                  child: Icon(
                    Icons.phone_android,
                    size: Dimens.thirtyTwo,
                    color: ColorValues.darkerGrayColor,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: ColorValues.grayColor,
                  radius: Dimens.twentyFour,
                  child: Icon(
                    Icons.phone_iphone,
                    size: Dimens.thirtyTwo,
                    color: ColorValues.darkerGrayColor,
                  ),
                ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: item.deviceModel!,
                  style: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                if (item.deviceId == AuthService.find.deviceId.toString())
                  TextSpan(
                    text: "  •",
                    style: AppStyles.style14Bold.copyWith(
                      color: ColorValues.successColor,
                    ),
                  ),
              ],
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: "${item.city!}, ${item.regionName!}, ${item.country!}",
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: GetTimeAgo.parse(
                    item.createdAt!.toLocal(),
                    pattern: 'dd MMM yyyy hh:mm a',
                  ),
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),
            ],
          ),
          trailingFlex: 0,
          trailing: GestureDetector(
            onTap: () => _showDeleteDialog(item.deviceId!),
            child: Icon(
              Icons.close,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(String deviceId) async {
    AppUtility.showSimpleDialog(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              'Delete',
              style: AppStyles.style18Bold,
            ),
          ),
          Dimens.dividerWithHeight,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NxTextButton(
                  label: StringValues.no,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.errorColor,
                  ),
                  onTap: AppUtility.closeDialog,
                  padding: Dimens.edgeInsets8,
                ),
                Dimens.boxWidth16,
                NxTextButton(
                  label: StringValues.yes,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.successColor,
                  ),
                  onTap: () async {
                    AppUtility.closeDialog();
                    if (deviceId == AuthService.find.deviceId.toString()) {
                      await AuthService.find.logout();
                      RouteManagement.goToWelcomeView();
                      return;
                    } else {
                      await LoginInfoController.find
                          .deleteLoginDeviceInfo(deviceId);
                    }
                  },
                  padding: Dimens.edgeInsets8,
                ),
              ],
            ),
          ),
          Dimens.boxHeight8,
        ],
      ),
    );
  }
}
