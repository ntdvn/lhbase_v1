import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class ToolbarPage extends StatefulWidget {
  const ToolbarPage({Key? key}) : super(key: key);

  @override
  _ToolbarPageState createState() => _ToolbarPageState();
}

class _ToolbarPageState extends State<ToolbarPage> {
  late ChatToolbarController _chatToolbarController;

  @override
  void initState() {
    _chatToolbarController = Get.put(ChatToolbarController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarBottom: LhAppBar.bottomEmpty(),
        child: Column(
          children: [
            Expanded(child: Container()),
            ChatToolbar(
              controller: _chatToolbarController,
              rightActionsBuilder: (state, output) {
                return [
                  if (output.text.isNotEmpty)
                    ChatKitAction(widget: Icon(Icons.send), onTap: () {}),
                ];
              },
              leftActionsBuilder: (state, output) {
                return state.toolbarRightFlag
                    ? [
                        ChatKitAction(
                            widget: Icon(Icons.add_circle), onTap: () {}),
                        ChatKitAction(widget: Icon(Icons.mic), onTap: () {}),
                        ChatKitAction(
                            widget: Icon(Icons.camera_alt), onTap: () {}),
                        ChatKitAction(widget: Icon(Icons.image), onTap: () {}),
                      ]
                    : [
                        ChatKitAction(
                            widget: Icon(Icons.chevron_right),
                            onTap: () {
                              _chatToolbarController
                                  .changeToolbarRightFlag(true);
                              // print(
                              //     "chatkit ${_chatKitController.state.toolbarRightFlag}");
                            }),
                      ];
              },
              // controller: TextEditingController(),
              focusNode: FocusNode(),
            )
          ],
        ));
  }
}
