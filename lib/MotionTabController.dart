import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MotionTabController extends ChangeNotifier {

  MotionTabController({int initialIndex,this.length = 3, @required TickerProvider vsync})
      : /*assert(length != null && length >= 0),*/
        assert(initialIndex != null &&
            initialIndex >= 0 &&
            (length == 0 || initialIndex < length)),
        _index = initialIndex,
        _previousIndex = initialIndex,
        _animationController = AnimationController.unbounded(
          value: initialIndex.toDouble(),
          vsync: vsync,
        );

  // Private constructor used by `_copyWith`. This allows a new TabController to
  // be created without having to create a new animationController.
  MotionTabController._({
    int index,
    int previousIndex,
    AnimationController animationController,
    this.length,
  })  : _index = index,
        _previousIndex = previousIndex,
        _animationController = animationController;

  MotionTabController _copyWith({int index, int length, int previousIndex}) {
    return MotionTabController._(
      index: index ?? _index,
      length: length ?? this.length,
      animationController: _animationController,
      previousIndex: previousIndex ?? _previousIndex,
    );
  }

  Animation<double> get animation => _animationController?.view;
  AnimationController _animationController;

  /// The total number of tabs.
  ///
  /// Typically greater than one. Must match [TabBar.tabs]'s and
  /// [TabBarView.children]'s length.
  int length = 3;

  void _changeIndex(int value, {Duration duration, Curve curve}) {
    assert(value != null);
    assert(value >= 0 && (value < length || length == 0));
    assert(duration != null || curve == null);
    assert(_indexIsChangingCount >= 0);
    if (value == _index || length < 2) return;
    _previousIndex = index;
    _index = value;
    if (duration != null) {
      _indexIsChangingCount += 1;
      notifyListeners(); // Because the value of indexIsChanging may have changed.
      _animationController
          .animateTo(_index.toDouble(), duration: duration, curve: curve)
          .whenCompleteOrCancel(() {
        _indexIsChangingCount -= 1;
        notifyListeners();
      });
    } else {
      _indexIsChangingCount += 1;
      _animationController.value = _index.toDouble();
      _indexIsChangingCount -= 1;
      notifyListeners();
    }
  }

  /// The index of the currently selected tab.
  ///
  /// Changing the index also updates [previousIndex], sets the [animation]'s
  /// value to index, resets [indexIsChanging] to false, and notifies listeners.
  ///
  /// To change the currently selected tab and play the [animation] use [animateTo].
  ///
  /// The value of [index] must be valid given [length]. If [length] is zero,
  /// then [index] will also be zero.
  int get index => _index;
  int _index;

  set index(int value) {
    _changeIndex(value);
  }

  /// The index of the previously selected tab.
  ///
  /// Initially the same as [index].
  int get previousIndex => _previousIndex;
  int _previousIndex;

  /// True while we're animating from [previousIndex] to [index] as a
  /// consequence of calling [animateTo].
  ///
  /// This value is true during the [animateTo] animation that's triggered when
  /// the user taps a [TabBar] tab. It is false when [offset] is changing as a
  /// consequence of the user dragging (and "flinging") the [TabBarView].
  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  /// Immediately sets [index] and [previousIndex] and then plays the
  /// [animation] from its current value to [index].
  ///
  /// While the animation is running [indexIsChanging] is true. When the
  /// animation completes [offset] will be 0.0.
  void animateTo(int value,
      {Duration duration = kTabScrollDuration, Curve curve = Curves.ease}) {
    _changeIndex(value, duration: duration, curve: curve);
  }

  /// The difference between the [animation]'s value and [index].
  ///
  /// The offset value must be between -1.0 and 1.0.
  ///
  /// This property is typically set by the [TabBarView] when the user
  /// drags left or right. A value between -1.0 and 0.0 implies that the
  /// TabBarView has been dragged to the left. Similarly a value between
  /// 0.0 and 1.0 implies that the TabBarView has been dragged to the right.
  double get offset => _animationController.value - _index.toDouble();

  set offset(double value) {
    assert(value != null);
    assert(value >= -1.0 && value <= 1.0);
    assert(!indexIsChanging);
    if (value == offset) return;
    _animationController.value = value + _index.toDouble();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}

class _TabControllerScope extends InheritedWidget {
  const _TabControllerScope({
    Key key,
    this.controller,
    this.enabled,
    Widget child,
  }) : super(key: key, child: child);

  final MotionTabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_TabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

class DefaultMotionTabController extends StatefulWidget {
  /// Creates a default tab controller for the given [child] widget.
  ///
  /// The [length] argument is typically greater than one. The [length] must
  /// match [TabBar.tabs]'s and [TabBarView.children]'s length.
  ///
  /// The [initialIndex] argument must not be null.
  const DefaultMotionTabController({
    Key key,
    this.length,
    this.initialIndex,
    @required this.child,
  })  : assert(initialIndex != null),
        assert(length >= 0),
        assert(length == 0 || (initialIndex >= 0 && initialIndex < length)),
        super(key: key);

  /// The total number of tabs.
  ///
  /// Typically greater than one. Must match [TabBar.tabs]'s and
  /// [TabBarView.children]'s length.
  final int length;

  /// The initial index of the selected tab.
  ///
  /// Defaults to zero.
  final int initialIndex;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Scaffold] whose [AppBar] includes a [TabBar].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage:
  ///
  /// ```dart
  /// TabController controller = DefaultTabBarController.of(context);
  /// ```
  static MotionTabController of(BuildContext context) {
    final _TabControllerScope scope =
        context.dependOnInheritedWidgetOfExactType<_TabControllerScope>();
    return scope?.controller;
  }

  @override
  _DefaultMotionTabControllerState createState() =>
      _DefaultMotionTabControllerState();
}

class _DefaultMotionTabControllerState extends State<DefaultMotionTabController>
    with SingleTickerProviderStateMixin {
  MotionTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MotionTabController(
      vsync: this,
      length: widget.length,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(DefaultMotionTabController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      // If the length is shortened while the last tab is selected, we should
      // automatically update the index of the controller to be the new last tab.
      int newIndex;
      int previousIndex = _controller.previousIndex;
      if (_controller.index >= widget.length) {
        newIndex = math.max(0, widget.length - 1);
        previousIndex = _controller.index;
      }
      _controller = _controller._copyWith(
        length: widget.length,
        index: newIndex,
        previousIndex: previousIndex,
      );
    }
  }
}
