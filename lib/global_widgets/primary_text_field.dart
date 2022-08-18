import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

class NxTextField extends StatelessWidget {
  const NxTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.fiftySix,
      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
      child: CupertinoTextField(
        padding: EdgeInsets.symmetric(horizontal: Dimens.sixTeen),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
          borderRadius: BorderRadius.circular(Dimens.eight),
        ),
        cursorColor: ColorValues.primaryColor,
        clearButtonMode: OverlayVisibilityMode.editing,
        keyboardType: TextInputType.text,
        maxLines: 1,
        placeholderStyle: AppStyles.style14Normal.copyWith(
          color: ColorValues.grayColor,
        ),
      ),
    );
  }
}
