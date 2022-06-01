class ChatKitState {
  bool _focus = false;

  bool get focus => _focus;

  set focus(bool focus) {
    _focus = focus;
  }

  bool _toolbarRightFlag = true;

  bool get toolbarRightFlag => _toolbarRightFlag;

  set toolbarRightFlag(bool toolbarRightFlag) {
    _toolbarRightFlag = toolbarRightFlag;
  }

  ChatKitState();
}
