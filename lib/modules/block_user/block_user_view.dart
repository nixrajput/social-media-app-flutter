import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/block_user/block_user_controller.dart';

class BlockUserView extends StatelessWidget {
  const BlockUserView({super.key});

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<BlockUserController>(
          builder: (logic) => Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Dimens.boxHeight12,
                _buildBlockUserHelpText(context),
                Dimens.boxHeight4,
                _buildBlockUserHelpTextDesc(context),
                Dimens.boxHeight12,
                _buildUserDetails(logic),
                Dimens.boxHeight24,
                _buildActionBtn(context, logic),
                Dimens.boxHeight12,
              ],
            ),
          ),
        ),
      ),
    );
  }

  NxListTile _buildUserDetails(BlockUserController logic) {
    return NxListTile(
      showBorder: false,
      padding: Dimens.edgeInsets12,
      borderRadius: BorderRadius.circular(Dimens.four),
      leading: AvatarWidget(
        avatar: logic.avatar,
        size: Dimens.twentyFour,
      ),
      title: Text(
        logic.uname,
        style: AppStyles.style14Bold,
      ),
    );
  }

  NxFilledButton _buildActionBtn(
      BuildContext context, BlockUserController logic) {
    return NxFilledButton(
      onTap: () => BlockUserController.find.blockUser(),
      label: StringValues.block.toUpperCase(),
      padding: Dimens.edgeInsetsDefault,
      height: Dimens.fiftySix,
    );
  }

  Text _buildBlockUserHelpTextDesc(BuildContext context) {
    return Text(
      StringValues.blockDesc,
      style: AppStyles.style13Normal.copyWith(
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
    );
  }

  Text _buildBlockUserHelpText(BuildContext context) {
    return Text(
      StringValues.blockUserHelp,
      style: AppStyles.style14Bold,
    );
  }

  NxAppBar _buildAppBar() {
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      title: StringValues.blockUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
