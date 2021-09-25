import 'package:flutter/material.dart';
import 'package:lhbase_v1/ui/widgets/lh_app_bar_action.dart';

class LhAppBarTop extends StatelessWidget {
  final Color? backgroundColor;
  final LhAppBarAction? leading;
  final List<LhAppBarAction>? actions;
  final String? title;
  final Widget? titles;

  const LhAppBarTop(
      {Key? key,
      this.backgroundColor,
      this.leading,
      this.actions,
      this.title,
      this.titles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              height: kToolbarHeight,
              child: Row(
                children: [_renderLeading(), _renderTitle()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _renderLeading() {
    return Container(child: leading ?? Icon(Icons.chevron_left));
  }

  _renderTitle() {
    var renderWidget = null;
    if (title != null) {
      renderWidget = Text(title!);
    } else if (titles != null) {
      renderWidget = titles;
    }
    return Container(child: renderWidget ?? Icon(Icons.chevron_left));
  }
}
