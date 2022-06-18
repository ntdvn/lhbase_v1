import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/widgets/view_list_image_screen.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef Widget MessageBuilder();

typedef Widget ActionBuilder(ChatMessage message);
typedef OnMessagedClicked(ChatMessage message);
typedef OnMessagedLongClicked(ChatMessage message);
typedef OnAvatarClicked(ChatMessage message);

class LhChatView extends StatefulWidget {
  final ChatKitController controller;
  final ActionBuilder? actionBuilder;
  final MessageBuilder? builder;
  final OnMessagedClicked? onMessagedClicked;
  final OnMessagedLongClicked? onMessagedLongClicked;
  final OnAvatarClicked? onAvatarClicked;
  final VoidCallback? onLoadMore;

  final Widget? toolBar;
  const LhChatView(
      {Key? key,
      required this.controller,
      this.actionBuilder,
      this.builder,
      this.onMessagedClicked,
      this.onMessagedLongClicked,
      this.onLoadMore,
      this.onAvatarClicked,
      this.toolBar})
      : super(key: key);

  @override
  _LhChatViewState createState() => _LhChatViewState();
}

class _LhChatViewState extends State<LhChatView> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatKitController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: controller.themeData.roomThemeData.backgroundImage !=
                            null
                        ? DecorationImage(
                            image: NetworkImage(controller
                                .themeData.roomThemeData.backgroundImage!),
                            fit: BoxFit.cover)
                        : null,
                    color: controller.themeData.roomThemeData.backgroundColor),
                child: Stack(
                  children: [
                    NotificationListener<ScrollNotification>(
                      onNotification: _handleScrollNotification,
                      child: ListView.builder(
                          addAutomaticKeepAlives: true,
                          controller: _controller,
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            return index == controller.messages.length-1 || (index != controller.messages.length-1 && LhValue.dateTimeToDate(controller.messages[index].time) != LhValue.dateTimeToDate(controller.messages[index+1].time))  ?
                            Column(
                              crossAxisAlignment: controller.messages[index].user == controller.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                                    child: LhText(LhValue.dateTimeToDate(controller.messages[index].time), style: LhStyle.DEFAULT_16.copyWith(color: Colors.black),),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: controller.user ==
                                            controller.messages[index].user
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.only(right: 10),
                                          child: (controller.user !=
                                                          controller.messages[index]
                                                              .user &&
                                                      controller.messages[index]
                                                              .position ==
                                                          ChatBubblePosition.LAST ||
                                                  controller.messages[index]
                                                          .position ==
                                                      ChatBubblePosition.SINGLE)
                                              ? LhAvatar(
                                                  imageUrl: controller
                                                      .messages[index]
                                                      .user
                                                      .imageUrl)
                                              : SizedBox.shrink()),
                                      Container(
                                          constraints: BoxConstraints(
                                              minWidth: 0,
                                              maxWidth: LhValue.messageFullWidth),
                                          child: ChatBubbleWidget(

                                            onLongPress: (){
                                              print("long click");
                                              if (widget.onMessagedLongClicked !=
                                                  null) {
                                                widget.onMessagedLongClicked!(
                                                    controller.messages[index]);
                                              }
                                            },
                                            message: controller.messages[index],
                                            chatBubbleType:
                                                controller.messages[index].position,
                                            margin:
                                                EdgeInsets.symmetric(vertical: 2),
                                            child: MessageRender(
                                                message:
                                                controller.messages[index]),
                                            // child: Text(
                                            //     'asdasdasdasdasdasd\nasdasdasdasdasdasd\n')
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ) :
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: controller.user ==
                                    controller.messages[index].user
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      child: (controller.user !=
                                          controller.messages[index]
                                              .user &&
                                          controller.messages[index]
                                              .position ==
                                              ChatBubblePosition.LAST ||
                                          controller.messages[index]
                                              .position ==
                                              ChatBubblePosition.SINGLE)
                                          ? WidgetNetworkImage(
                                        image: controller.messages[index].user.imageUrl,
                                        height: 40,
                                        width: 40,
                                        borderRadius: 100,
                                        fit: BoxFit.cover,
                                        onTap: (){
                                          if (widget.onAvatarClicked != null) {
                                            widget.onAvatarClicked!(controller.messages[index]);}
                                          })

                                          // LhAvatar(
                                          //         imageUrl: controller.messages[index].user.imageUrl)
                                              : SizedBox.shrink()),
                                          Container(
                                          constraints: BoxConstraints(
                                          minWidth: 0,
                                          maxWidth: LhValue.messageFullWidth),
                                          child: ChatBubbleWidget(
                                          onTap: () {
                                          if (widget.onMessagedClicked !=
                                          null) {
                                          widget.onMessagedClicked!(
                                          controller.messages[index]);
                                          }
                                          },
                                          onLongPress: (){
                                          if (widget.onMessagedLongClicked !=
                                          null) {
                                          widget.onMessagedLongClicked!(
                                          controller.messages[index]);
                                          }
                                          },
                                          message: controller.messages[index],
                                          chatBubbleType:
                                          controller.messages[index].position,
                                          margin:
                                          EdgeInsets.symmetric(vertical: 2
                                        ),
                                        child:
                                        MessageRender(
                                            message:
                                            controller.messages[index]),
                                        // child: Text(
                                        //     'asdasdasdasdasdasd\nasdasdasdasdasdasd\n')
                                      )),
                                ],
                              ),
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: GetX<ChatKitController>(
                        builder: (controller) {
                          return controller.isLoading
                              ? Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.toolBar != null) widget.toolBar!
          ],
        );
      },
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter == 0) {
        if (widget.onLoadMore != null) widget.onLoadMore!();
      }
    }
    return false;
  }
}
