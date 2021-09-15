import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBasePage extends StatefulWidget {
  final Widget child;

  const LhBasePage({Key? key, required this.child}) : super(key: key);

  @override
  _LhBasePageState createState() => _LhBasePageState();
}

class _LhBasePageState extends State<LhBasePage> {
  @override
  Widget build(BuildContext context) {
    return KeyBoarDismisserWidget(
      child: SafeArea(
          child: Scaffold(
        body: widget.child,
      )),
    );
  }
}
