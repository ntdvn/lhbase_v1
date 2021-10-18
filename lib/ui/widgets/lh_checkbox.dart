import 'package:flutter/material.dart';

typedef Widget LhCheckBoxBuilder(bool isChecked);

class LhCheckBox extends StatefulWidget {
  bool value;
  final double? width;
  final double? height;
  final LhCheckBoxBuilder builder;
  final ValueChanged<bool>? onChanged;

  LhCheckBox(
      {Key? key,
      this.width,
      this.height,
      required this.value,
      required this.builder,
      this.onChanged})
      : super(key: key);

  @override
  _LhCheckBoxState createState() => _LhCheckBoxState();
}

class _LhCheckBoxState extends State<LhCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   widget.value = !widget.value;
        // });
        if (widget.onChanged != null) widget.onChanged!(!widget.value);
      },
      child: Container(
        child: widget.builder(widget.value),
      ),
    );
  }
}
