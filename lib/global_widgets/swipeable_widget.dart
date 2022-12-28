import 'package:flutter/material.dart';
import 'package:social_media_app/utils/utility.dart';

/// SwipeTo is a wrapper widget to other Widget that we can swipe horizontally
/// to initiate a callback when animation gets end.
/// It is useful to develop and What's App kind of replay animation for a
/// component of ongoing chat.
class NxSwipeableWidget extends StatefulWidget {
  /// Child widget for which you want to have horizontal swipe action
  /// @required parameter
  final Widget child;

  /// Duration value to define animation duration
  /// if not passed default Duration(milliseconds: 150) will be taken
  final Duration animationDuration;

  /// Icon that will be displayed beneath child widget when swipe right
  final IconData iconOnRightSwipe;

  /// Widget that will be displayed beneath child widget when swipe right
  final Widget? rightSwipeWidget;

  /// Icon that will be displayed beneath child widget when swipe left
  final IconData iconOnLeftSwipe;

  /// Widget that will be displayed beneath child widget when swipe right
  final Widget? leftSwipeWidget;

  /// double value defining size of displayed icon beneath child widget
  /// if not specified default size 26 will be taken
  final double iconSize;

  /// color value defining color of displayed icon beneath child widget
  ///if not specified primaryColor from theme will be taken
  final Color? iconColor;

  /// Double value till which position child widget will get animate when swipe left
  /// or swipe right
  /// if not specified 0.3 default will be taken for Right Swipe &
  /// it's negative -0.3 will bve taken for Left Swipe
  final double offsetDx;

  /// callback which will be initiated at the end of child widget animation
  /// when swiped right
  /// if not passed swipe to right will be not available
  final GestureDragUpdateCallback? onRightSwipe;

  /// callback which will be initiated at the end of child widget animation
  /// when swiped left
  /// if not passed swipe to left will be not available
  final GestureDragUpdateCallback? onLeftSwipe;

  const NxSwipeableWidget({
    Key? key,
    required this.child,
    this.onRightSwipe,
    this.onLeftSwipe,
    this.iconOnRightSwipe = Icons.reply,
    this.rightSwipeWidget,
    this.iconOnLeftSwipe = Icons.reply,
    this.leftSwipeWidget,
    this.iconSize = 26.0,
    this.iconColor,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetDx = 0.3,
  }) : super(key: key);

  @override
  NxSwipeableWidgetState createState() => NxSwipeableWidgetState();
}

class NxSwipeableWidgetState extends State<NxSwipeableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _leftIconAnimation;
  late Animation<double> _rightIconAnimation;
  late GestureDragUpdateCallback _onSwipeLeft;
  late GestureDragUpdateCallback _onSwipeRight;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    _leftIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _rightIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _onSwipeLeft = widget.onLeftSwipe ??
        (details) {
          AppUtility.printLog("Left Swipe Not Provided");
        };

    _onSwipeRight = widget.onRightSwipe ??
        (details) {
          AppUtility.printLog("Right Swipe Not Provided");
        };
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///Run animation for child widget
  ///[onRight] value defines animation Offset direction
  void _runAnimation({required bool onRight, details}) {
    //set child animation
    _animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(onRight ? widget.offsetDx : -widget.offsetDx, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    //set back left/right icon animation
    if (onRight) {
      _leftIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    } else {
      _rightIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    }
    //Forward animation
    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (onRight) {
          //keep left icon visibility to 0.0 until onRightSwipe triggers again
          _leftIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          _onSwipeRight(details);
        } else {
          //keep right icon visibility to 0.0 until onLeftSwipe triggers again
          _rightIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));

          _onSwipeLeft(details);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 1 && widget.onRightSwipe != null) {
          _runAnimation(onRight: true, details: details);
        }
        if (details.delta.dx < -1 && widget.onLeftSwipe != null) {
          _runAnimation(onRight: false, details: details);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AnimatedOpacity(
                opacity: _leftIconAnimation.value,
                duration: widget.animationDuration,
                curve: Curves.decelerate,
                child: widget.rightSwipeWidget ??
                    Icon(
                      widget.iconOnRightSwipe,
                      size: widget.iconSize,
                      color:
                          widget.iconColor ?? Theme.of(context).iconTheme.color,
                    ),
              ),
              AnimatedOpacity(
                opacity: _rightIconAnimation.value,
                duration: widget.animationDuration,
                curve: Curves.decelerate,
                child: widget.leftSwipeWidget ??
                    Icon(
                      widget.iconOnLeftSwipe,
                      size: widget.iconSize,
                      color:
                          widget.iconColor ?? Theme.of(context).iconTheme.color,
                    ),
              ),
            ],
          ),
          SlideTransition(
            position: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
