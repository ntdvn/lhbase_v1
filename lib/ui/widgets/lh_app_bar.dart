import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_app_bar_action.dart';

enum LhAppBarType { TOP, BOTTOM }

// typedef LhLeadingCallback = bool Function();

enum LhAppBarBehavior {
  SCROLLED,
  STACKED,
}

class LhAppBar extends StatelessWidget {
  // final double? height;
  final LhAppBarBehavior? behavior;
  final LhAppBarType type;
  final double? elevation;
  final Color? backgroundColor;
  final Decoration? decoration;

  final List<LhAppBarAction>? leading;
  final Color? leadingColor;
  final WillPopCallback? leadingOnTap;
  final List<LhAppBarAction>? actions;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? titles;
  final Widget? backgroundImage;
  final double? height;
  final double? sizeIcon;

  const LhAppBar(
      {Key? key,
      this.behavior = LhAppBarBehavior.SCROLLED,
      required this.type,
      // this.height,
      this.elevation = 0,
      this.backgroundColor,
      this.decoration,
      this.leading,
      this.leadingColor,
      this.leadingOnTap,
      this.actions,
      this.title,
      this.titleStyle,
      this.titles,
      this.backgroundImage,
      this.height, this.sizeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: elevation ?? 0,
    // margin: EdgeInsets.zero,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(0.0),
    // ),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       // color: backgroundColor ?? Theme.of(context).primaryColor,
    //       // color: Colors.transparent
    //     ),
    //     child: Stack(
    //       children: [
    //         if (backgroundImage != null)
    //           Positioned.fill(child: backgroundImage!),
    //         Column(
    //           children: [
    //             Container(
    //               margin: EdgeInsets.only(
    //                   top: type == LhAppBarType.TOP
    //                       ? MediaQuery.of(context).padding.top
    //                       : 0,
    //                   bottom: type == LhAppBarType.BOTTOM
    //                       ? MediaQuery.of(context).padding.bottom
    //                       : 0),
    //               height: height ?? kToolbarHeight,
    //               child: Row(
    //                 children: [
    //                   _renderLeading(context),
    //                   Expanded(child: _renderTitle()),
    //                   if (actions != null) ...(actions as List<Widget>)
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      color: backgroundColor,
      margin: EdgeInsets.zero,
      decoration: decoration,
      child: Stack(
        children: [
          if (backgroundImage != null) Positioned.fill(child: backgroundImage!),
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
                height: height ?? kToolbarHeight,
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
                size: sizeIcon ?? 24,
              ),
              onTap: () {
                handlerLeadingOnTap(context);
              });
        }
      }
    }
    // if (.canPop!=null)
    return leadingWidget ?? SizedBox.shrink();
  }

  handlerLeadingOnTap(BuildContext context) async {
    if (leadingOnTap != null) {
      if (await leadingOnTap!()) Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
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
      {LhAppBarBehavior? behavior = LhAppBarBehavior.SCROLLED,
      double? elevation,
      @Deprecated("Use decoration instead") Color? backgroundColor,
      Decoration? decoration,
      List<LhAppBarAction>? leading,
      Color? leadingColor,
      WillPopCallback? leadingOnTap,
      List<LhAppBarAction>? actions,
      String? title,
      TextStyle? titleStyle,
      Widget? titles,
      Widget? backgroundImage,
      double? height,
      double? sizeIcon}) {
    return LhAppBar(
      behavior: behavior,
      type: LhAppBarType.TOP,
      elevation: elevation,
      backgroundColor: backgroundColor,
      decoration: decoration,
      leading: leading,
      leadingColor: leadingColor,
      leadingOnTap: leadingOnTap,
      actions: actions,
      title: title,
      titleStyle: titleStyle,
      titles: titles,
      backgroundImage: backgroundImage,
      height: height,
      sizeIcon: sizeIcon,
    );
  }

  factory LhAppBar.bottom(
      {double? elevation,
      @Deprecated("Use decoration instead") Color? backgroundColor,
      Decoration? decoration,
      List<LhAppBarAction>? leading,
      Color? leadingColor,
      WillPopCallback? leadingOnTap,
      List<LhAppBarAction>? actions,
      String? title,
      TextStyle? titleStyle,
      Widget? titles,
      Widget? backgroundImage,
      double? height}) {
    return LhAppBar(
      type: LhAppBarType.BOTTOM,
      elevation: elevation,
      backgroundColor: backgroundColor,
      decoration: decoration,
      leading: leading,
      leadingColor: leadingColor,
      leadingOnTap: leadingOnTap,
      actions: actions,
      title: title,
      titleStyle: titleStyle,
      titles: titles,
      backgroundImage: backgroundImage,
      height: height,
    );
  }

  factory LhAppBar.topEmpty({
    Color? backgroundColor,
  }) {
    return LhAppBar(
      type: LhAppBarType.TOP,
      backgroundColor: backgroundColor,
      height: 0,
      leading: [],
    );
  }

  factory LhAppBar.bottomEmpty({
    Color? backgroundColor,
  }) {
    return LhAppBar(
      type: LhAppBarType.BOTTOM,
      backgroundColor: backgroundColor,
      height: 0,
      leading: [],
    );
  }
}
