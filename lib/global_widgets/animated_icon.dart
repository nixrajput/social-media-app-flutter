import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

const double _kDefaultAnimationAngle = 2 * 3.14;

class NxAnimatedIcon extends StatefulWidget {
  const NxAnimatedIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.angle,
    this.controller,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final double? angle;
  final AnimationController? controller;

  @override
  State<NxAnimatedIcon> createState() => _NxAnimatedIconState();
}

class _NxAnimatedIconState extends State<NxAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller ?? _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: (widget.controller != null
                  ? widget.controller!.value
                  : _controller.value) *
              (widget.angle ?? _kDefaultAnimationAngle),
          child: child,
        );
      },
      child: Icon(
        widget.icon,
        size: widget.size ?? Dimens.twentyFour,
        color: widget.color ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}
