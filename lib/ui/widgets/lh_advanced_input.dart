import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef Widget LhInputWidgetBuilder(LhInputBuilder lhInputBuilder);
typedef Decoration LhContainerWidgetBuilder(LhInputBuilder lhInputBuilder);

class LhAdvancedInput extends StatefulWidget {
  final int? line;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? formTextStyle;
  final String? hint;
  final bool? enable;
  final String? initialValue;
  final TextStyle? formHintStyle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  final int? maxLength;
  final LhInputWidgetBuilder? builderTop;
  final LhInputWidgetBuilder? builderBottom;
  final LhInputWidgetBuilder? builderLeft;
  final LhInputWidgetBuilder? builderRight;
  final LhContainerWidgetBuilder? builderContainer;
  final Decoration? inputContainerDecoration;

  final EdgeInsets? inputPadding;
  final EdgeInsets? inputMargin;
  final bool obscureText;
  const LhAdvancedInput({
    Key? key,
    this.line,
    this.focusNode,
    required this.controller,
    this.inputFormatters,
    this.formTextStyle,
    this.hint,
    this.enable,
    this.initialValue,
    this.formHintStyle,
    this.keyboardType,
    this.onChanged,
    this.maxLength,
    this.builderTop,
    this.builderBottom,
    this.builderLeft,
    this.builderRight,
    this.builderContainer,
    this.inputContainerDecoration,
    this.inputPadding,
    this.inputMargin,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _LhAdvancedInputState createState() => _LhAdvancedInputState();
}

class _LhAdvancedInputState extends State<LhAdvancedInput> {
  bool _inputIsFocused = false;

  @override
  void initState() {
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() {
        setState(() {
          _inputIsFocused = widget.focusNode!.hasFocus;
        });
      });
    }

    // widget.controller.addListener(() {
    //   if (!mounted) return;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildInput());
  }

  Widget _buildInput() {
    return Column(
      children: [
        if (widget.builderTop != null)
          widget.builderTop!(LhInputBuilder(
              inputLength: widget.controller.text.length,
              isFocused: _inputIsFocused)),
        AnimatedContainer(
          margin: widget.inputMargin,
          decoration: widget.builderContainer != null
              ? widget.builderContainer!(LhInputBuilder(
                  inputLength: widget.controller.text.length,
                  isFocused: _inputIsFocused))
              : null,
          duration: Duration(milliseconds: 300),
          child: Row(
            children: [
              if (widget.builderLeft != null)
                widget.builderLeft!(LhInputBuilder(
                    inputLength: widget.controller.text.length,
                    isFocused: _inputIsFocused)),
              Expanded(
                child: LhBorderLessInput(
                  initialValue: widget.initialValue,
                  keyboardType: widget.keyboardType,
                  line: widget.line,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  enable: widget.enable,
                  onChanged: (value) {
                    if (widget.onChanged != null) widget.onChanged!(value);
                  },
                  padding: widget.inputPadding,
                  hint: widget.hint,
                  formTextStyle: widget.formTextStyle,
                  formHintStyle: widget.formHintStyle,
                  inputFormatters: [
                    if (widget.inputFormatters != null)
                      ...widget.inputFormatters!,
                    if (widget.maxLength != null)
                      LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  obscureText: widget.obscureText,
                ),
              ),
              if (widget.builderRight != null)
                widget.builderRight!(LhInputBuilder(
                    inputLength: widget.controller.text.length,
                    isFocused: _inputIsFocused)),
            ],
          ),
        ),
        if (widget.builderBottom != null)
          widget.builderBottom!(LhInputBuilder(
              inputLength: widget.controller.text.length,
              isFocused: _inputIsFocused)),
      ],
    );
  }
}
