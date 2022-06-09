import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessage message;
  final ChatBubblePosition chatBubbleType;
  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final ActionBuilder? actionBuilder;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ChatBubbleWidget(
      {Key? key,
      required this.message,
      this.child,
      this.color = Colors.cyan,
      this.chatBubbleType = ChatBubblePosition.SINGLE,
      this.padding,
      this.margin,
      this.actionBuilder,
      this.onTap,
      this.onLongPress,
      })
      : super(key: key);

  static const double activeDefault = 15;
  static const double inactiveDefault = activeDefault / 5;

  @override
  Widget build(BuildContext context) {
    Radius defaultRadius = Radius.circular(0.0);
    Radius rTopLeft = defaultRadius = defaultRadius,
        rBottomLeft = defaultRadius,
        rTopRight = defaultRadius,
        rBottomRight = defaultRadius;
    if (chatBubbleType == ChatBubblePosition.FIRST) {
      rTopLeft = Radius.circular(activeDefault);
      rBottomLeft = Radius.circular(inactiveDefault);
      rTopRight = Radius.circular(activeDefault);
      rBottomRight = Radius.circular(activeDefault);
    }

    if (chatBubbleType == ChatBubblePosition.MIDDLE) {
      rTopLeft = Radius.circular(inactiveDefault);
      rBottomLeft = Radius.circular(inactiveDefault);
      rTopRight = Radius.circular(activeDefault);
      rBottomRight = Radius.circular(activeDefault);
    }

    if (chatBubbleType == ChatBubblePosition.LAST) {
      rTopLeft = Radius.circular(inactiveDefault);
      rBottomLeft = Radius.circular(activeDefault);
      rTopRight = Radius.circular(activeDefault);
      rBottomRight = Radius.circular(activeDefault);
    }

    if (chatBubbleType == ChatBubblePosition.FIRST_MINE) {
      rTopLeft = Radius.circular(activeDefault);
      rBottomLeft = Radius.circular(activeDefault);
      rTopRight = Radius.circular(activeDefault);
      rBottomRight = Radius.circular(inactiveDefault);
    }

    if (chatBubbleType == ChatBubblePosition.MIDDLE_MINE) {
      rTopLeft = Radius.circular(activeDefault);
      rBottomLeft = Radius.circular(activeDefault);
      rTopRight = Radius.circular(inactiveDefault);
      rBottomRight = Radius.circular(inactiveDefault);
    }

    if (chatBubbleType == ChatBubblePosition.LAST_MINE) {
      rTopLeft = Radius.circular(activeDefault);
      rBottomLeft = Radius.circular(activeDefault);
      rTopRight = Radius.circular(inactiveDefault);
      rBottomRight = Radius.circular(activeDefault);
    }

    if (chatBubbleType == ChatBubblePosition.SINGLE ||
        chatBubbleType == ChatBubblePosition.SINGLE_MINE) {
      rTopLeft = Radius.circular(activeDefault);
      rBottomLeft = Radius.circular(activeDefault);
      rTopRight = Radius.circular(activeDefault);
      rBottomRight = Radius.circular(activeDefault);
    }

    var borderRadius = BorderRadius.only(
        topLeft: rTopLeft,
        bottomLeft: rBottomLeft,
        topRight: rTopRight,
        bottomRight: rBottomRight);

    return GetBuilder<ChatKitController>(
      builder: (controller) {
        return Container(
          child: Row(
            mainAxisAlignment: controller.user == message.user
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (controller.user == message.user && actionBuilder != null)
                Flexible(
                  flex: 3,
                  child: actionBuilder!(message),
                ),
              Flexible(
                flex: 7,
                child: Card(
                  // color: Colors.red,
                  elevation: 0,
                  margin: margin,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                    // side: BorderSide(color: Colors.red, width: 1)
                  ),
                  clipBehavior: Clip.antiAlias,
                  semanticContainer: true,
                  child: LhInkwell(
                    onTap: onTap,
                    onLongPress: onLongPress,
                    // padding: padding,
                    padding: EdgeInsets.zero,
                    borderRadius: borderRadius,
                    decoration: BoxDecoration(
                        color: controller.user == message.user
                            ? controller
                                .themeData.mBubbleThemeData.backgroundColor
                            : controller
                                .themeData.bubbleThemeData.backgroundColor
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment
                        //       .bottomCenter, // 10% of the width, so there are ten blinds.
                        //   colors: <Color>[Colors.blue, Colors.yellow], // red to yellow
                        //   tileMode: TileMode.repeated, // repeats the gradient over the canvas
                        // ),
                        ),
                    child: child!,
                  ),
                ),
              ),
              if (controller.user != message.user && actionBuilder != null)
                Flexible(
                  flex: 3,
                  child: actionBuilder!(message),
                ),
            ],
          ),
        );
      },
    );
  }
}
