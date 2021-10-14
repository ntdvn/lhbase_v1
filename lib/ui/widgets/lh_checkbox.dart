import 'package:flutter/material.dart';

typedef Widget LhCheckBoxBuilder(bool isChecked);

class LhCheckBox extends StatefulWidget {
  final bool value;
  final double? width;
  final double? height;
  final LhCheckBoxBuilder builder;
  final ValueChanged<bool>? onChanged;

  const LhCheckBox(
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
  late bool _isCheck;
  @override
  void initState() {
    _isCheck = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCheck = !_isCheck;
        });
        if (widget.onChanged != null) widget.onChanged!(_isCheck);
      },
      child: Container(
        child: widget.builder(_isCheck),
      ),
    );
  }
}
