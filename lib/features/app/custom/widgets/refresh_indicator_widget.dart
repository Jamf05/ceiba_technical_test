import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorWidget extends StatelessWidget with BaseWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const RefreshIndicatorWidget(
      {Key? key, required this.onRefresh, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseWidget.init(context);
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
