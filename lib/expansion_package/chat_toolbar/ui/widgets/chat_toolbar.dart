import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_toolbar/ui/controllers/controllers.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef List<ChatKitAction> ActionsBuilder(
    ChatKitState state, ChatKitOutput output);

class ChatToolbar extends StatefulWidget {
  final ChatToolbarController controller;
  // final TextEditingController textEditController;
  final FocusNode focusNode;
  final ActionsBuilder? leftActionsBuilder;
  final ActionsBuilder? rightActionsBuilder;
  final ValueChanged<String>? onInputChanged;
  final ValueChanged<String>? onInputSubmitted;

  const ChatToolbar(
      {Key? key,
      required this.controller,
      required this.focusNode,
      this.leftActionsBuilder,
      this.rightActionsBuilder,
      this.onInputChanged,
      this.onInputSubmitted})
      : super(key: key);

  @override
  _ChatToolbarState createState() => _ChatToolbarState();
}

class _ChatToolbarState extends State<ChatToolbar> {
  

  Duration _animTime = Duration(milliseconds: 250);

  @override
  void initState() {
    widget.focusNode.addListener(() {
      widget.controller.changeFocus(widget.focusNode.hasFocus);
      widget.controller.changeToolbarRightFlag(!widget.focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatToolbarController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: controller.themeData.toolbarThemeData.height,
          decoration: BoxDecoration(color: Colors.grey.shade100),
          child: Stack(
            children: [
              Positioned.fill(
                  child: AnimatedContainer(
                duration: _animTime,
                color: controller.themeData.toolbarThemeData.backgroundColor,
                child: Row(
                  children: [
                    if (widget.leftActionsBuilder != null)
                      _renderActions(
                          controller,
                          widget.leftActionsBuilder!(
                              controller.state, controller.output)),
                    Expanded(child: _renderInput(controller)),
                    if (widget.rightActionsBuilder != null)
                      _renderActions(
                          controller,
                          widget.rightActionsBuilder!(
                              controller.state, controller.output)),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  Widget _renderActions(
      ChatToolbarController controller, List<ChatKitAction>? actions) {
    List<ChatKitAction> mActions;
    if (actions == null)
      mActions = [];
    else {
      // ThemeData a = ThemeData(textButtonTheme: );
      mActions = actions;
    }
    return AnimatedContainer(
      width: controller.themeData.actionTheme.size * mActions.length,
      duration: Duration(milliseconds: 200),
      child: Row(
        children: [
          ...List.generate(
              mActions.length,
              (index) => Expanded(
                    child: ChatAction(
                      action: mActions[index],
                    ),
                  )),
        ],
      ),
    );
  }


  Widget _renderInput(ChatToolbarController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 2, bottom: 6, left: 10, right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(7.0),
        focusColor: Colors.red,
        splashColor: Colors.red,
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: controller.themeData.toolbarThemeData.inputBackgroundColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                style: TextStyle(fontSize: 18),
                onChanged: (value) {
                  controller.changeText(value);
                },
                focusNode: widget.focusNode,
                onSubmitted: widget.onInputSubmitted,
                decoration: InputDecoration(
                    // enabled: false,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
              )),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 25,
                height: 25,
                // color: Colors.red,
                // child: LhAppBarAction.icon(
                //   iconFactor: 1,
                //   icon: Image.asset(
                //     'assets/images/chat_like.png',
                //   ),
                //   onTap: () {},
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }
}
