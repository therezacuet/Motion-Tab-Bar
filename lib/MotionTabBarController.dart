import 'package:flutter/material.dart';

class MotionTabBarController extends TabController {
  MotionTabBarController({
    int initialIndex = 0,
    Duration? animationDuration,
    required int length,
    required TickerProvider vsync,
  }) : super(initialIndex: initialIndex, animationDuration: animationDuration, length: length, vsync: vsync);

  // programmatic tab change
  set index(int index) {
    super.index = index;
    _changeIndex!(index);
  }

  // callback for tab change
  Function(int)? _changeIndex;
  set onTabChange(Function(int)? fx) {
    _changeIndex = fx;
  }
}