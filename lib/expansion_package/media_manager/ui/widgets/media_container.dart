import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class MediaContainer extends StatefulWidget {
  final Widget child;
  final MediaSelectType type;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? selectedText;
  const MediaContainer(
      {Key? key,
      required this.child,
      required this.type,
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
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      onTap: widget.onTap,
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (widget.type == MediaSelectType.MULTIPLE)
            Align(
              alignment: Alignment.topRight,
              child: LhCheckBox(
                // value: checked.contains(entity),
                value: widget.isSelected,
                onChanged: (value) {
                  print('value $value');
                  // if (checked.contains(entity)) {
                  //   checked.remove(entity);
                  // } else {
                  //   checked.add(entity);
                  // }
                  // setState(() {});
                },
                builder: (bool isChecked) {
                  return isChecked
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7)),
                          child: Container(
                              alignment: Alignment.center,
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(500.0)),
                              child: Text(
                                '${widget.selectedText ?? ''}',
                                style: LhStyle.DEFAULT_16
                                    .copyWith(color: Colors.white),
                              )),
                        )
                      : SizedBox.shrink();
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
