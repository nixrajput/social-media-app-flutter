import 'package:flutter/material.dart';

class GlobalStringKey extends GlobalObjectKey {
  GlobalStringKey(super.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalStringKey &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => super.hashCode ^ value.hashCode;
}
