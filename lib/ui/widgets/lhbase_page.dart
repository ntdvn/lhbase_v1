import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatefulWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;
  final bool isPaddingTop;
  final bool isPaddingBottom;
  final LhAppBar? appBarTop;
  final Widget? appBarBottom;
  final LhSlidingPanel? bottomSlidingPanel;
  final Brightness statusBarBrightness;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool keyboardDimissable;
  final Key? keyScaffold;

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
      this.bottomSlidingPanel,
      this.statusBarBrightness = Brightness.light,
      this.floatingActionButtonLocation,
      this.drawer,
      this.endDrawer,
      this.keyScaffold,
      this.keyboardDimissable = false,
      this.floatingActionButtonAnimator})
      : super(key: key);

  @override
  _LhBasePageState createState() => _LhBasePageState();
}

class _LhBasePageState extends State<LhBasePage> {
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: () {
        ComponentUtils.setStatusBarBrightness(widget.statusBarBrightness);
      },
      child: KeyBoarDismisserWidget(
        keyboardDimissable: widget.keyboardDimissable,
        child: WillPopScope(
          onWillPop: widget.onWillPop,
          child: Container(
            padding: EdgeInsets.only(
                top: widget.isPaddingTop
                    ? MediaQuery.of(context).padding.top
                    : 0,
                bottom: widget.isPaddingBottom
                    ? MediaQuery.of(context).padding.bottom
                    : 0),
            child: Scaffold(
              key: widget.keyScaffold,
              body: Stack(
                children: [
                  Align(alignment: Alignment.topCenter, child: Column(children: [
                    if (widget.appBarTop != null &&
                          widget.appBarTop!.behavior ==
                              LhAppBarBehavior.STACKED)   widget.appBarTop as Widget,
                  ],),),
                  Column(
                    children: [
                      if (widget.appBarTop != null &&
                          widget.appBarTop!.behavior ==
                              LhAppBarBehavior.SCROLLED)
                        widget.appBarTop as Widget,
                      Expanded(child: widget.child),
                      if (widget.appBarBottom != null)
                        widget.appBarBottom as Widget,
                      if (widget.bottomSlidingPanel != null)
                        Container(
                            height: widget
                                .bottomSlidingPanel!.controller.currentHeight)
                    ],
                  ),
                  if (widget.bottomSlidingPanel != null)
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Wrap(
                          children: [
                            Container(
                                color: Colors.red,
                                child: widget.bottomSlidingPanel as Widget),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
              floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
              appBar: widget.appBar,
              drawer: widget.drawer,
              endDrawer: widget.endDrawer,
            ),
          ),
        ),
      ),
    );
  }
}
