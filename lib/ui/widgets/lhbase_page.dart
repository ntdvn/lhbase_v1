import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;
  final bool isPaddingTop;

  const LhBasePage(
      {Key? key,
      required this.child,
      this.onWillPop,
      this.floatingActionButton,
      this.appBar,
      this.isPaddingTop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyBoarDismisserWidget(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          padding: isPaddingTop
              ? EdgeInsets.only(top: MediaQuery.of(context).padding.top)
              : null,
          child: Scaffold(
            body: child,
            floatingActionButton: floatingActionButton,
            appBar: appBar,
          ),
        ),
      ),
    );
  }
}
