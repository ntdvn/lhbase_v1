import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_kit_output.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_kit_state.dart';
import 'package:lhbase_v1/expansion_package/chat_toolbar/models/themes/chat_toolbar_theme_data.dart';

class ChatToolbarController extends GetxController {
  Rx<ChatToolbarThemeData> _themeData = Rx(ChatToolbarThemeData());

  ChatToolbarThemeData get themeData => _themeData.value;

  set themeData(ChatToolbarThemeData themeData) {
    _themeData.value = themeData;
  }

  Rx<ChatKitState> _state = Rx(ChatKitState());

  ChatKitState get state => _state.value;

  set state(ChatKitState state) {
    _state.value = state;
  }

  Rx<ChatKitOutput> _output = Rx(ChatKitOutput());

  ChatKitOutput get output => _output.value;

  set output(ChatKitOutput output) {
    _output.value = output;
  }

  changeText(String value) {
    output.text = value;
    update();
  }

  changeFocus(bool value) {
    state.focus = value;
    update();
  }

  changeToolbarRightFlag(bool value) {
    state.toolbarRightFlag = value;
    update();
  }
}
