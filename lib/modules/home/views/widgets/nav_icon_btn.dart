import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/animated_icon.dart';

class NavIconBtn extends StatefulWidget {
  const NavIconBtn({
    super.key,
    required this.icon,
    required this.itemsCount,
    required this.isActive,
    this.width,
    this.height,
    this.onTap,
    this.showBadge,
    this.bgColor,
    this.iconSize,
    this.iconColor,
  });

  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool isActive;
  final bool? showBadge;
  final int itemsCount;
  final Color? bgColor;

  @override
  State<NavIconBtn> createState() => _NavIconBtnState();
}

class _NavIconBtnState extends State<NavIconBtn>
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
    return GestureDetector(
      onTap: () {
        _animateIcon();
        widget.onTap!();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        curve: Curves.easeInOut,
        width: (Dimens.screenWidth - Dimens.twentyFour) / widget.itemsCount,
        height: double.infinity,
        color: widget.bgColor ?? ColorValues.transparent,
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                width: widget.width ?? Dimens.twentyFour,
                height: widget.height ?? Dimens.twentyFour,
                child: NxAnimatedIcon(
                  icon: widget.icon,
                  size: widget.iconSize ?? Dimens.twentyFour,
                  color: widget.iconColor ??
                      Theme.of(context).textTheme.bodyText1!.color,
                  controller: _animationController,
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
        ),
      ),
    );
  }
}
