import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class NxRiveAssetWidget extends StatefulWidget {
  const NxRiveAssetWidget({super.key, required this.asset});

  final String asset;

  @override
  State<NxRiveAssetWidget> createState() => _NxRiveAssetWidgetState();
}

class _NxRiveAssetWidgetState extends State<NxRiveAssetWidget> {
  late final _fileLoader = FileLoader.fromAsset(
    widget.asset,
    riveFactory: Factory.rive,
  );

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBuilder(
      fileLoader: _fileLoader,
      builder: (context, state) => switch (state) {
        RiveLoaded() => RiveWidget(controller: state.controller),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
