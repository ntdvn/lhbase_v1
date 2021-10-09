import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class Expandable extends StatefulWidget {
  final String name;
  final String? title;

  const Expandable({Key? key, required this.name, this.title})
      : super(key: key);

  @override
  _ButtonChooseState createState() => _ButtonChooseState();
}

class _ButtonChooseState extends State<Expandable>
    with TickerProviderStateMixin {
  Animation? _arrowAnimation;
  AnimationController? _arrowAnimationController;
  bool isExpand = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: pi / 2, end: pi * 1.5).animate(_arrowAnimationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              _arrowAnimationController!.isCompleted
                  ? _arrowAnimationController!.reverse()
                  : _arrowAnimationController!.forward();
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.0195),
              child: Row(
                children: [
                  Expanded(
                    child: LhText(
                      widget.name,
                      maxLines: 1,
                      style: LhStyle.DEFAULT_16.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _arrowAnimationController!,
                    builder: (context, child) => Transform.rotate(
                      angle: _arrowAnimation!.value,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: Container(),
          secondChild: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.04, 0, Get.width * 0.04, Get.height * 0.03),
            color: Colors.white,
            child: SingleChildScrollView(
              child: LhText(
                widget.title ?? 'kdsndsjpo',
                style: LhStyle.DEFAULT_14.copyWith(
                    fontWeight: FontWeight.w400, color: Color(0xffC4C4C4)),
              ),
            ),
          ),
          crossFadeState:
              isExpand ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )
      ],
    );
  }
}
