import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/loading_indicator.dart';
import 'package:social_media_app/constants/dimens.dart';

final _tKey = GlobalKey(debugLabel: 'overlay_parent');

OverlayEntry? _loaderEntry;

bool _loaderShown = false;

class NxOverlayWidget extends StatelessWidget {
  final Widget child;

  const NxOverlayWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overLayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigatorState;

  void visitor(Element element) {
    if (navigatorState != null) return;

    if (element.widget is Navigator) {
      navigatorState = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);

  assert(navigatorState != null, '''unable to show overlay''');
  return navigatorState!.overlay;
}

abstract class AppOverlay {
  static Future<void> showLoadingIndicator({
    bool? isModal,
    Color? modalColor,
    String? message,
    bool? dismissible,
  }) async {
    try {
      final _child = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const NxLoadingIndicator(),
            if (message != null) Dimens.boxHeight8,
            if (message != null)
              RichText(
                text: TextSpan(
                  text: message,
                  style: TextStyle(
                    fontSize: Dimens.sixTeen,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      );
      await _showOverlay(
        child: isModal ?? true
            ? Stack(
                children: <Widget>[
                  ModalBarrier(
                    color: modalColor ??
                        Theme.of(Get.context!)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.5)
                            .withAlpha(50),
                    dismissible: dismissible ?? false,
                  ),
                  _child
                ],
              )
            : _child,
      );
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> hideLoadingIndicator() async {
    try {
      await _hideOverlay();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _showOverlay({required Widget child}) async {
    try {
      final overlay = _overLayState;

      if (_loaderShown) {
        return Future.value();
      }

      final overlayEntry = OverlayEntry(
        builder: (context) => child,
      );

      overlay?.insert(overlayEntry);
      _loaderEntry = overlayEntry;
      _loaderShown = true;
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _hideOverlay() async {
    try {
      _loaderEntry!.remove();
      _loaderShown = false;
    } catch (err) {
      rethrow;
    }
  }
}
