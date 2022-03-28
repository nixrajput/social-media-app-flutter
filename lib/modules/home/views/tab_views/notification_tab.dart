import 'package:flutter/material.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            NxSliverAppBar(
              isFloating: false,
              isPinned: true,
              bgColor: Theme.of(context).scaffoldBackgroundColor,
              leading: Text(
                StringValues.notifications,
                style: AppStyles.style18Bold,
              ),
            ),
            SliverFillRemaining(
              child: _buildNotificationBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBody() => Column();
}
