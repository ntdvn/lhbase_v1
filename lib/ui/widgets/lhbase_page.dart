import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatefulWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final WillPopCallback? onWillPop;
  final PreferredSizeWidget? appBar;

  const LhBasePage(
      {Key? key,
      required this.child,
      this.onWillPop,
      this.floatingActionButton,
      this.appBar})
      : super(key: key);

  @override
  _LhBasePageState createState() => _LhBasePageState();
}

class _LhBasePageState extends State<LhBasePage> {
  @override
  Widget build(BuildContext context) {
    return KeyBoarDismisserWidget(
      child: WillPopScope(
        onWillPop: widget.onWillPop,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Scaffold(
            body: widget.child,
            floatingActionButton: widget.floatingActionButton,
            appBar: widget.appBar,
          ),
        ),
      ),
    );
  }
}
