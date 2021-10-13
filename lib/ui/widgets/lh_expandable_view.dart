import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhExpanableView extends StatefulWidget {
  // final Listenable controller;
  final Widget child;
  final LhExpanableController controller;
  const LhExpanableView(
      {Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  _LhExpanableViewState createState() => _LhExpanableViewState();
}

class _LhExpanableViewState extends State<LhExpanableView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        if (widget.controller.isShow) {
          return Container(
              width: double.infinity,
              color: Colors.transparent,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [_buildBackdrop(), _buildExpanableView()],
                ),
              ));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  static final backDropColor = Colors.black.withOpacity(0.8);

  Widget _buildBackdrop() {
    return GestureDetector(
      onTap: () {
        widget.controller.closed();
      },
      child: Container(
        // duration: Duration(microseconds: 1),
        width: LhExpanableController.screenWidth,
        height:
            LhExpanableController.screenHeight - widget.controller.height >= 0
                ? LhExpanableController.screenHeight - widget.controller.height
                : 0,
        // height: widget.controller.currentHeight,
        color: backDropColor,
      ),
    );
  }

  Widget _buildExpanableView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return GestureDetector(
                  // onVerticalDragUpdate: (details) {
                  //   widget.controller.delta(-details.delta.dy);
                  //   widget.controller.action = LhExpanableAction.SCROLLING;
                  // },
                  // onVerticalDragEnd: (details) {
                  //   // widget.controller.onChangedEnd();
                  //   print('${details.velocity}');
                  //   widget.controller.action = LhExpanableAction.IDLE;
                  // },
                  child: Container(
                color: backDropColor,
                height: widget.controller.height,
                child: widget.child,
              ));
            },
          )
        ],
      ),
    );
  }
}
