import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/animated_icon.dart';
import 'package:social_media_app/modules/home/views/widgets/animated_bar.dart';

class BottomNavItem extends StatefulWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.itemsCount,
    required this.isActive,
    this.onTap,
    this.showBadge,
    this.bgColor,
    this.iconSize,
    this.iconColor,
  });

  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isActive;
  final bool? showBadge;
  final int itemsCount;
  final Color? bgColor;

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController.forward();
  }

  void _animateIcon() {
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = (Dimens.screenWidth - Dimens.twentyFour) / widget.itemsCount;

    return GestureDetector(
      onTap: () {
        _animateIcon();
        widget.onTap!();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        color: widget.bgColor ?? ColorValues.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBar(isActive: widget.isActive),
              Stack(
                children: [
                  SizedBox(
                    width: widget.iconSize ?? Dimens.twentyFour,
                    height: widget.iconSize ?? Dimens.twentyFour,
                    child: Opacity(
                      opacity: widget.isActive ? 1.0 : 0.5,
                      child: NxAnimatedIcon(
                        icon: widget.icon,
                        size: widget.iconSize ?? Dimens.twentyFour,
                        color: widget.iconColor ??
                            Theme.of(context).textTheme.bodyLarge!.color,
                        controller: _animationController,
                      ),
                    ),
                  ),
                  if (widget.showBadge == true)
                    Positioned(
                      top: Dimens.zero,
                      right: Dimens.zero,
                      child: Container(
                        width: Dimens.six,
                        height: Dimens.six,
                        decoration: const BoxDecoration(
                          color: ColorValues.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
