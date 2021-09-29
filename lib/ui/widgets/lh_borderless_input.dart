import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBorderLessInput extends StatelessWidget {
  final int? line;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? formTextStyle;
  final String? hint;
  final String? initialValue;
  final TextStyle? formHintStyle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  const LhBorderLessInput(
      {Key? key,
      this.line = 1,
      this.focusNode,
      this.controller,
      this.inputFormatters,
      this.formTextStyle,
      this.hint,
      this.formHintStyle,
      this.onChanged,
      this.initialValue,
      this.keyboardType,
      this.padding,
      this.prefixIcon,
      this.suffixIcon,
      this.suffix})
      : super(key: key);

  static final titleStyle = LhStyle.DEFAULT_16_BOLD;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        focusNode: focusNode,
        minLines: line,
        maxLines: line,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: formTextStyle ??
            LhStyle.DEFAULT_12
                .copyWith(fontStyle: FontStyle.normal, color: Colors.black),
        onChanged: onChanged,
        scrollPadding: EdgeInsets.zero,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: padding ?? EdgeInsets.zero,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hint,
            hintStyle: formHintStyle ??
                LhStyle.DEFAULT_12.copyWith(
                    fontStyle: FontStyle.italic, color: Color(0xff828282)),
            prefixIconConstraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffix: suffix));
  }
}
