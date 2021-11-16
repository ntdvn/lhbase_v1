import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;
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
  final bool? resizeToAvoidBottomInset;

  const LhBasePage(
      {Key? key,
      required this.child,
      this.backgroundColor = Colors.white,
      this.onWillPop,
      this.floatingActionButton,
      this.appBar,
      this.appBarTop,
      this.appBarBottom,
      this.bottomSlidingPanel,
      this.statusBarBrightness = Brightness.light,
      this.floatingActionButtonLocation,
      this.drawer,
      this.endDrawer,
      this.keyScaffold,
      this.keyboardDimissable = false,
      this.floatingActionButtonAnimator,
      this.resizeToAvoidBottomInset})
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
          child: Scaffold(
            key: widget.keyScaffold,
            body: Container(
              color: widget.backgroundColor,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
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
                  ),
                  if (widget.appBarTop != null &&
                      widget.appBarTop!.behavior == LhAppBarBehavior.STACKED)
                    Positioned.fill(
                      child: Wrap(
                        children: [
                          widget.appBarTop as Widget,
                        ],
                      ),
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
            ),
            floatingActionButton: widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            appBar: widget.appBar,
            drawer: widget.drawer,
            endDrawer: widget.endDrawer,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          ),
        ),
      ),
    );
  }
}
