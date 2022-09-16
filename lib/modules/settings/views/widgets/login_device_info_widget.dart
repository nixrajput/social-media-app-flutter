import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/login_device_info.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginDeviceInfoWidget extends StatelessWidget {
  const LoginDeviceInfoWidget({
    Key? key,
    required this.item,
    required this.totalLength,
    required this.index,
  }) : super(key: key);

  final LoginDeviceInfo item;
  final int totalLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialog(item.deviceId!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NxListTile(
            padding: Dimens.edgeInsets8,
            bgColor: Theme.of(Get.context!).dialogBackgroundColor,
            borderRadius: (index == 0 || index == totalLength - 1)
                ? BorderRadius.only(
                    topLeft: Radius.circular(
                        index == 0 ? Dimens.eight : Dimens.zero),
                    topRight: Radius.circular(
                        index == 0 ? Dimens.eight : Dimens.zero),
                    bottomLeft: Radius.circular(
                        index == totalLength - 1 ? Dimens.eight : Dimens.zero),
                    bottomRight: Radius.circular(
                        index == totalLength - 1 ? Dimens.eight : Dimens.zero),
                  )
                : const BorderRadius.all(Radius.zero),
            leading: Icon(
              Icons.location_on_outlined,
              size: Dimens.twenty,
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            title: RichText(
              text: TextSpan(
                text:
                    "${item.locationInfo!.city!}, ${item.locationInfo!.regionName!}, ${item.locationInfo!.country!}",
                style: AppStyles.style16Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: item.deviceInfo!['model'],
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                  ),
                  if (item.deviceId == AuthService.find.deviceId)
                    TextSpan(
                      text: "  •",
                      style: AppStyles.style14Bold.copyWith(
                        color: ColorValues.successColor,
                      ),
                    ),
                ],
              ),
            ),
            trailing: GestureDetector(
              onTap: () => _showDeleteDialog(item.deviceId!),
              child: Icon(
                Icons.delete,
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
          if (index != totalLength - 1) Dimens.divider,
        ],
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
                    if (deviceId == AuthService.find.deviceId) {
                      await AuthService.find.logout();
                      RouteManagement.goToWelcomeView();
                      return;
                    } else {
                      await LoginDeviceInfoController.find
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
