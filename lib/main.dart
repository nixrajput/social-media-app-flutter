import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        // Full TelemetryClient crash wiring needs a live session/device id and
        // lands in the posts plan; foundation records to console.
        debugPrint('FlutterError: ${details.exception}');
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        debugPrint('Uncaught: $error');
        return true;
      };
      runApp(const ProviderScope(child: App()));
    },
    (error, stack) {
      debugPrint('Zone error: $error');
    },
  );
}
