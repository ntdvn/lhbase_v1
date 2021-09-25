import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_app_bar_action.dart';

class LhAppBarTop extends StatelessWidget {
  // final double? height;
  final double? elevation;
  final Color? backgroundColor;
  final LhAppBarAction? leading;
  final Color? leadingColor;
  final List<LhAppBarAction>? actions;
  final String? title;
  final Widget? titles;
  final Widget? backgroundImage;

  const LhAppBarTop(
      {Key? key,

      // this.height,
      this.elevation,
      this.backgroundColor,
      this.leading,
      this.leadingColor,
      this.actions,
      this.title,
      this.titles,
      this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            if (backgroundImage != null)
              Positioned.fill(child: backgroundImage!),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  // height: height ?? kToolbarHeight,
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      _renderLeading(context),
                      Expanded(child: _renderTitle()),
                      if (actions != null) ...(actions as List<Widget>)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _renderLeading(BuildContext context) {
    var leadingWidget = null;
    if (leading != null) {
    } else {
      if (ModalRoute.of(context) != null) {
        if (ModalRoute.of(context)!.canPop) {
          leadingWidget = LhAppBarAction.icon(
            icon: Icon(
              Icons.chevron_left,
              color: leadingColor ?? Theme.of(context).primaryIconTheme.color,
            ),
            onTap: () => Navigator.of(context).pop(),
          );
        }
      }
    }
    // if (.canPop!=null)
    return leadingWidget ?? SizedBox.shrink();
  }

  _renderTitle() {
    var renderWidget = null;
    if (title != null) {
      renderWidget = Text(
        title!,
        style: LhStyle.DEFAULT_14,
      );
    } else if (titles != null) {
      renderWidget = titles;
    }
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: renderWidget ?? SizedBox.shrink());
  }
}
