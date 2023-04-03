import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    Key? key,
    this.showIndicator = false,
    this.flashingCircleDarkColor = ColorValues.primaryColor,
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  }) : super(key: key);

  final bool showIndicator;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  TypingIndicatorState createState() => TypingIndicatorState();
}

class TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: Dimens.zero,
      end: Dimens.sixty,
    ));

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 1000)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 500)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(child: child);
      },
      child: _buildStatusBubble(),
    );
  }

  Widget _buildStatusBubble() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildFlashingCircle(0),
        Dimens.boxWidth4,
        _buildFlashingCircle(1),
        Dimens.boxWidth4,
        _buildFlashingCircle(2),
      ],
    );
  }

  Widget _buildFlashingCircle(int index) {
    return AnimatedBuilder(
      animation: _repeatingController,
      builder: (context, child) {
        final circleFlashPercent =
            _dotIntervals[index].transform(_repeatingController.value);
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: Dimens.eight,
          height: Dimens.eight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(widget.flashingCircleDarkColor,
                widget.flashingCircleBrightColor, circleColorPercent),
          ),
        );
      },
    );
  }
}
