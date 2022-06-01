import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_kit_action.dart';
import 'package:lhbase_v1/expansion_package/chat_toolbar/ui/ui.dart';
import 'package:lhbase_v1/lhbase.dart';

class ChatAction extends StatelessWidget {
  final ChatKitAction action;
  const ChatAction({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChatToolbarController>(
      builder: (controller) {
        return Stack(
          children: [
            Container(
              width: controller.themeData.toolbarThemeData.height,
              height: double.infinity,
              child: action.widget,
            ),
            if (action.onTap != null)
              Positioned.fill(
                  child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(500.0),
                      onTap: action.onTap,
                    ),
                  ),
                ),
              ))
          ],
        );
      },
    );
  }
}
