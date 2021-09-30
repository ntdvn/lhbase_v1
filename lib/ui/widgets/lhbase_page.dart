import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;
  final bool isPaddingTop;
  final bool isPaddingBottom;
  final LhAppBar? appBarTop;
  final Widget? appBarBottom;
  final LhSlidingPanel? bottomSlidingPanel;

  const LhBasePage(
      {Key? key,
      required this.child,
      this.onWillPop,
      this.floatingActionButton,
      this.appBar,
      this.isPaddingTop = false,
      this.isPaddingBottom = false,
      this.appBarTop,
      this.appBarBottom,
      this.bottomSlidingPanel})
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
            body: Stack(
              children: [
                Column(
                  children: [
                    if (appBarTop != null) appBarTop as Widget,
                    Expanded(child: child),
                    if (appBarBottom != null) appBarBottom as Widget,
                    if (bottomSlidingPanel != null)
                      Container(
                          height: bottomSlidingPanel!.controller.currentHeight)
                  ],
                ),
                if (bottomSlidingPanel != null)
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Wrap(
                        children: [
                          Container(
                              color: Colors.red,
                              child: bottomSlidingPanel as Widget),
                        ],
                      ),
                    ),
                  )
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
