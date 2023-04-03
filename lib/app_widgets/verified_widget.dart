import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class VerifiedWidget extends StatelessWidget {
  const VerifiedWidget({
    super.key,
    required this.verifiedCategory,
    this.size,
  });

  final String verifiedCategory;
  final double? size;

  Color getIconColor(String category) {
    switch (category) {
      case 'verified':
        return ColorValues.primaryColor;
      case 'unverified':
        return ColorValues.primaryColor;
      case 'pending':
        return ColorValues.primaryColor;
      case 'rejected':
        return ColorValues.primaryColor;
      default:
        return ColorValues.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.verified,
      color: getIconColor(verifiedCategory),
      size: size ?? Dimens.twenty,
    );
  }
}
