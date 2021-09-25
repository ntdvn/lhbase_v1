import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;
  final bool isPaddingTop;
  final bool isPaddingBottom;
  final LhAppBarTop? appBarTop;
  final Widget? appBarBottom;

  const LhBasePage(
      {Key? key,
      required this.child,
      this.onWillPop,
      this.floatingActionButton,
      this.appBar,
      this.isPaddingTop = false,
      this.isPaddingBottom = false,
      this.appBarTop,
      this.appBarBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyBoarDismisserWidget(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          padding: EdgeInsets.only(
              top: isPaddingTop ? MediaQuery.of(context).padding.top : 0,
              bottom:
                  isPaddingBottom ? MediaQuery.of(context).padding.bottom : 0),
          child: Scaffold(
            body: Column(
              children: [
                if (appBarTop != null) appBarTop as Widget,
                Expanded(child: child),
                if (appBarBottom != null) appBarBottom as Widget,
              ],
            ),
            floatingActionButton: floatingActionButton,
            appBar: appBar,
          ),
        ),
      ),
    );
  }
}
