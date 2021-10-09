import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhInputSearch extends StatefulWidget {
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
  const LhInputSearch(
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
      this.padding})
      : super(key: key);

  @override
  _LhInputSearchState createState() => _LhInputSearchState();
}

class _LhInputSearchState extends State<LhInputSearch> {
  @override
  Widget build(BuildContext context) {
    print('render');
    return LhAdvancedInput(
      line: 1,
      controller: widget.controller,
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
        setState(() {});
      },
      // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      hint: widget.hint,
      formTextStyle: widget.formTextStyle,
      formHintStyle: widget.formHintStyle,
      builderLeft: (lhInputBuilder) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Icon(
            Icons.search,
            color: Colors.grey,
            size: widget.formTextStyle != null
                ? widget.formTextStyle!.fontSize
                : null,
          ),
        );
      },
      builderRight: (lhInputBuilder) {
       
        return lhInputBuilder.inputLength > 0
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: () {
                      widget.controller.text = '';
                      widget.controller.notifyListeners();
                      setState(() {});
                    },
                    child: Container(
                        width: 25,
                        height: 25,
                        child: LhAppBarAction.icon(
                            iconFactor: 1,
                            icon: Icon(
                              Icons.close,
                              size: widget.formTextStyle != null
                                  ? widget.formTextStyle!.fontSize
                                  : null,
                            )))))
            : SizedBox.shrink();
      },
    );
  }
}
