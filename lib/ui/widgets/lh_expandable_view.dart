import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhExpanableView extends StatefulWidget {
  // final Listenable controller;
  final LhExpanableController controller;
  const LhExpanableView({Key? key, required this.controller}) : super(key: key);

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
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }

  Widget _buildExpanableView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return GestureDetector(
                  onVerticalDragUpdate: (details) {
                    widget.controller.delta(-details.delta.dy);
                  },
                  onVerticalDragEnd: (details) {
                    // widget.controller.onChangedEnd();
                  },
                  child: Container(
                    color: Colors.white,
                    height: widget.controller.height,
                    child: GestureDetector(
                      onTap: () {
                        widget.controller.closed();
                      },
                      child: Text(
                        'width: 100, height: 300, color: Colors.green',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
