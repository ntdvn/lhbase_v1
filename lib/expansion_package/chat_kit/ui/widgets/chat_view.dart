import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef Widget MessageBuilder();

typedef Widget ActionBuilder(ChatMessage message);
typedef OnMessagedClicked(ChatMessage message);

class LhChatView extends StatefulWidget {
  final ChatKitController controller;
  final ActionBuilder? actionBuilder;
  final MessageBuilder? builder;
  final OnMessagedClicked? onMessagedClicked;
  final VoidCallback? onLoadMore;

  final Widget? toolBar;
  const LhChatView(
      {Key? key,
      required this.controller,
      this.actionBuilder,
      this.builder,
      this.onMessagedClicked,
      this.onLoadMore,
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
                            return Container(
                              key: UniqueKey(),
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
                                        onTap: () {
                                          if (widget.onMessagedClicked !=
                                              null) {
                                            widget.onMessagedClicked!(
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
