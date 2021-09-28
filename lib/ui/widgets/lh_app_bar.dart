import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_app_bar_action.dart';

enum LhAppBarType { TOP, BOTTOM }

class LhAppBar extends StatelessWidget {
  // final double? height;
  final LhAppBarType type;
  final double? elevation;
  final Color? backgroundColor;
  final List<LhAppBarAction>? leading;
  final Color? leadingColor;
  final List<LhAppBarAction>? actions;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? titles;
  final Widget? backgroundImage;

  const LhAppBar(
      {Key? key,
      required this.type,
      // this.height,
      this.elevation = 0,
      this.backgroundColor,
      this.leading,
      this.leadingColor,
      this.actions,
      this.title,
      this.titleStyle,
      this.titles,
      this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 0,
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
                  margin: EdgeInsets.only(
                      top: type == LhAppBarType.TOP
                          ? MediaQuery.of(context).padding.top
                          : 0,
                      bottom: type == LhAppBarType.BOTTOM
                          ? MediaQuery.of(context).padding.bottom
                          : 0),
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

  Widget _renderLeading(BuildContext context) {
    Widget? leadingWidget = null;
    if (leading != null) {
      leadingWidget = Row(
        children: leading as List<Widget>,
      );
    } else {
      if (ModalRoute.of(context) != null && type == LhAppBarType.TOP) {
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
      renderWidget = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        child: Text(
          title!,
          style: titleStyle ?? LhStyle.DEFAULT_14,
        ),
      );
    } else if (titles != null) {
      renderWidget = titles;
    }
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: renderWidget ?? SizedBox.shrink());
  }

  factory LhAppBar.top(
      {double? elevation,
      Color? backgroundColor,
      List<LhAppBarAction>? leading,
      Color? leadingColor,
      List<LhAppBarAction>? actions,
      String? title,
      TextStyle? titleStyle,
      Widget? titles,
      Widget? backgroundImage}) {
    return LhAppBar(
        type: LhAppBarType.TOP,
        elevation: elevation,
        backgroundColor: backgroundColor,
        leading: leading,
        leadingColor: leadingColor,
        actions: actions,
        title: title,
        titleStyle: titleStyle,
        titles: titles,
        backgroundImage: backgroundImage);
  }

  factory LhAppBar.bottom(
      {double? elevation,
      Color? backgroundColor,
      List<LhAppBarAction>? leading,
      Color? leadingColor,
      List<LhAppBarAction>? actions,
      String? title,
      TextStyle? titleStyle,
      Widget? titles,
      Widget? backgroundImage}) {
    return LhAppBar(
        type: LhAppBarType.BOTTOM,
        elevation: elevation,
        backgroundColor: backgroundColor,
        leading: leading,
        leadingColor: leadingColor,
        actions: actions,
        title: title,
        titleStyle: titleStyle,
        titles: titles,
        backgroundImage: backgroundImage);
  }
}
