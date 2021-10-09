import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class Expandable extends StatefulWidget {
  final double? angleBegin;
  final double? angleEnd;
  final Widget? header;
  final Widget? expand;
  final Widget? animeWidget;
  final Duration? duration;
  

  const Expandable(
      {Key? key, this.expand, this.duration, this.angleBegin, this.angleEnd, this.header,this.animeWidget})
      : super(key: key);

  @override
  _ButtonChooseState createState() => _ButtonChooseState();
}

class _ButtonChooseState extends State<Expandable>
    with TickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;
  bool isExpand = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this,
            duration:widget.duration ?? Duration(milliseconds: 300));
    animation =
        Tween(begin: widget.angleBegin ?? pi / 2,
            end: widget.angleEnd ?? pi * 1.5).animate(
            animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              animationController!.isCompleted
                  ? animationController!.reverse()
                  : animationController!.forward();
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: widget.header ?? Container()
                  ),
                  AnimatedBuilder(
                    animation: animationController!,
                    builder: (context, child) =>
                        Transform.rotate(
                          angle: animation!.value,
                          child:widget.animeWidget?? Icon(
                            Icons.arrow_forward_ios,
                            size:  20.0,
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
          duration:widget.duration ?? Duration(milliseconds: 300),
          firstChild: Container(),
          secondChild: widget.expand ?? Container(),
          crossFadeState:
          isExpand ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )
      ],
    );
  }
}
