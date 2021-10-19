import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class MediaContainer extends StatefulWidget {
  final Widget child;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? selectedText;
  const MediaContainer(
      {Key? key,
      required this.child,
      required this.isSelected,
      this.onTap,
      this.selectedText})
      : super(key: key);

  @override
  _MediaContainerState createState() => _MediaContainerState();
}

class _MediaContainerState extends State<MediaContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return LhInkwell(
        onTap: widget.onTap,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.child,
          ),
          if(widget.isSelected) Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              color: widget.isSelected
                  ? Colors.white.withOpacity(0.7)
                  : Colors.transparent,
              child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: LhValue.circleRadius),
                  child: Text('${widget.selectedText}', style: LhStyle.DEFAULT_14.copyWith(color: Colors.white),))),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
