// This class for passed down scroll controller
import 'package:flutter/material.dart';

class MyInheritedData extends InheritedWidget {
  const MyInheritedData({
    super.key,
    required this.scrollController,
    required super.child,
  });

  final ScrollController scrollController;

  static MyInheritedData of(BuildContext context) {
    final MyInheritedData? result =
        context.dependOnInheritedWidgetOfExactType<MyInheritedData>();
    assert(result != null, 'No Data found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInheritedData oldWidget) =>
      scrollController != oldWidget.scrollController;
}