import 'package:flutter/material.dart';

class ProgressNotifier extends ValueNotifier<ProgressBarState> {
  ProgressNotifier() : super(_initialValue);
  static const _initialValue = ProgressBarState(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  );
  
}

class ProgressBarState {
  const ProgressBarState({
    this.current,
    this.buffered,
    this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}
