import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhDropdownView extends StatefulWidget {
  final LhDropdownViewController controller;
  final Widget child;
  final Widget dropdownPanel;
  final Color color;
  final VoidCallback? onClosed;
  const LhDropdownView(
      {Key? key,
      required this.controller,
      required this.child,
      required this.dropdownPanel,
      this.color = Colors.white,
      this.onClosed})
      : super(key: key);

  @override
  _LhDropdownViewState createState() => _LhDropdownViewState();
}

class _LhDropdownViewState extends State<LhDropdownView> {
  late GlobalKey _key;
  late GlobalKey _overlayKey;
  bool isMenuOpen = false;
  OverlayEntry? _overlayEntry;
  late Offset buttonPosition;
  late Size childSize;

  @override
  void initState() {
    _key = LabeledGlobalKey("button_icon");
    _overlayKey = LabeledGlobalKey("overlay_key");

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
    childSize = renderBox.size;
  }

  void closeMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      isMenuOpen = !isMenuOpen;
    }
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry!);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(
          // borderRadius: _borderRadius,
          ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              widget.controller.togglePanel();
              // if (isMenuOpen) {
              //   closeMenu();
              // } else {
              //   openMenu();
              // }
            },
            child: widget.child,
          ),
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                // add your code here.

                if (widget.controller.isPanelShow == true) {
                  openMenu();
                } else {
                  closeMenu();
                }
              });

              return SizedBox();
            },
          )
        ],
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
                    onTap: () {
                      widget.controller.togglePanel();
                    },
                    child: Container(
                      // duration: Duration(seconds: 1),
                      color: Colors.black.withOpacity(0.5),
                    ))),
            Positioned(
                top: buttonPosition.dy,
                left: buttonPosition.dx,
                child: Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.child,
                        Column(
                          // key: _overlayKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                ),
                                ClipPath(
                                  clipper: ArrowClipper(),
                                  child: Container(
                                    width: 17,
                                    height: 17,
                                    color: widget.color,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: widget.color,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: widget.dropdownPanel,
                            ),
                          ],
                        ),
                      ],
                    ))),
          ],
        );
      },
    );
  }
}
