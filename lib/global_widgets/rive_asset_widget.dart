import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveTimerAnimatedIcon extends StatefulWidget {
  const RiveTimerAnimatedIcon({
    super.key,
    required this.asset,
    this.artboard,
    this.initAnimation,
    this.autoPlay,
  });

  final String asset;
  final String? artboard;
  final String? initAnimation;
  final bool? autoPlay;

  @override
  State<RiveTimerAnimatedIcon> createState() => _RiveTimerAnimatedIconState();
}

class _RiveTimerAnimatedIconState extends State<RiveTimerAnimatedIcon> {
  late RiveAnimationController<dynamic> controller;

  @override
  void initState() {
    super.initState();
    controller = SimpleAnimation(
      widget.initAnimation ?? 'idle',
      autoplay: widget.autoPlay ?? true,
    );
  }

  void togglePlay() =>
      setState(() => controller.isActive = !controller.isActive);

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      widget.asset,
      artboard: widget.artboard,
      controllers: [controller],
      antialiasing: true,
    );
  }
}
