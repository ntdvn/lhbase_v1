import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhMultiUseInput extends StatefulWidget {
  final int? line;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? formTextStyle;
  final String? hint;
  final String? initialValue;
  final TextStyle? formHintStyle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? padding;
  final Widget? prefix;
  final Widget? suffix;
  const LhMultiUseInput(
      {Key? key,
      this.line,
      this.focusNode,
      required this.controller,
      this.inputFormatters,
      this.formTextStyle,
      this.hint,
      this.initialValue,
      this.formHintStyle,
      this.keyboardType,
      this.onChanged,
      this.padding,
      this.prefix,
      this.suffix})
      : super(key: key);

  @override
  _LhMultiUseInputState createState() => _LhMultiUseInputState();
}

class _LhMultiUseInputState extends State<LhMultiUseInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.prefix != null) widget.prefix!,
        Expanded(
          child: LhBorderLessInput(
            line: widget.line,
            controller: widget.controller,
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
              setState(() {});
            },
            // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            hint: widget.hint,
            formTextStyle: widget.formTextStyle,
            formHintStyle: widget.formHintStyle,
          ),
        ),
        if (widget.suffix != null) widget.suffix!,
      ],
    );
  }
}
