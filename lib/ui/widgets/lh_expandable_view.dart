import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhExpanableView extends StatefulWidget {
  // final Listenable controller;
  final Widget child;
  final Widget? backdrop;
  final LhExpanableController controller;
  const LhExpanableView(
      {Key? key, required this.controller, required this.child, this.backdrop})
      : super(key: key);

  @override
  _LhExpanableViewState createState() => _LhExpanableViewState();
}

class _LhExpanableViewState extends State<LhExpanableView> {
  @override
  void initState() {
    super.initState();
  }

  Size? _size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Stack(
          children: [
            if (_size == null)
              LhMeasureSize(
                onChange: (Size size) {
                  setState(() {
                    _size = size;
                  });
                  widget.controller.maximizeHeight = size.height;
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
            if (widget.controller.isShow)
              Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [_buildBackdrop(), _buildExpanableView()],
                    ),
                  ))
          ],
        );
      },
    );
  }

  Widget _buildBackdrop() {
    return GestureDetector(
      onTap: () {
        widget.controller.closed();
      },
      child: Container(
        // duration: Duration(microseconds: 1),
        width: LhExpanableController.screenWidth,
        height: widget.controller.maximizeHeight - widget.controller.height >= 0
            ? widget.controller.maximizeHeight - widget.controller.height
            : 0,
        // height: widget.controller.currentHeight,
        color: LhColors.backdropColor,
        child: widget.backdrop,
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
          GestureDetector(
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
            // duration: Duration(milliseconds: 1),

            height: widget.controller.height < widget.controller.minimizeHeight
                ? widget.controller.minimizeHeight
                : widget.controller.height,
            // height: 0,
            child: Material(color: Colors.transparent, child: widget.child),
          ))
        ],
      ),
    );
  }
}
