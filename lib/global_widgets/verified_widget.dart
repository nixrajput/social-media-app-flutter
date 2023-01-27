import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class VerifiedWidget extends StatelessWidget {
  const VerifiedWidget({super.key, required this.verifiedCategory});

  final String verifiedCategory;

  Color getIconColor(String category) {
    return ColorValues.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.verified,
        color: getIconColor(verifiedCategory),
        size: Dimens.twenty,
      ),
    );
  }
}
