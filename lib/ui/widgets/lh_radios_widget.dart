import 'package:flutter/material.dart';

class LhRadiosWidget<T> extends StatefulWidget {
  final int? initialIndex;
  final List<T> items;
  // final List<T>? selectedItem;
  final Widget Function(int, T, T?) radioBuilder;
  final Function(int, T)? onSelectedChanged;
  final MultiChildRenderObjectWidget? containerWidget;
  const LhRadiosWidget(
      {Key? key,
      required this.items,
      // this.selectedItem,
      required this.radioBuilder,
      this.onSelectedChanged,
      this.initialIndex,
      this.containerWidget})
      : assert(items.length != 0),
        super(key: key);

  @override
  _LhRadiosWidgetState createState() => _LhRadiosWidgetState<T>();
}

class _LhRadiosWidgetState<T> extends State<LhRadiosWidget<T>> {
  T? _selectedItem;

  _onSelectedChange(int index) {
    if (widget.onSelectedChanged != null && _selectedItem != null) {
      widget.onSelectedChanged!(index, _selectedItem!);
    }
  }

  @override
  void initState() {
    if (widget.initialIndex != null) {
      _selectedItem = widget.items[widget.initialIndex!];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget _renderWidget;
    if (widget.containerWidget is Column) {
      var parent = widget.containerWidget as Column;
      _renderWidget = Column(
        mainAxisAlignment: parent.mainAxisAlignment,
        crossAxisAlignment: parent.crossAxisAlignment,
        mainAxisSize: parent.mainAxisSize,
        verticalDirection: parent.verticalDirection,
        textDirection: parent.textDirection,
        textBaseline: parent.textBaseline,
        children: _renderChildren(),
      );
    } else if (widget.containerWidget is Row) {
      var parent = widget.containerWidget as Row;
      _renderWidget = Row(
        mainAxisAlignment: parent.mainAxisAlignment,
        crossAxisAlignment: parent.crossAxisAlignment,
        mainAxisSize: parent.mainAxisSize,
        verticalDirection: parent.verticalDirection,
        textDirection: parent.textDirection,
        textBaseline: parent.textBaseline,
        children: _renderChildren(),
      );
    }
    if (widget.containerWidget is Wrap) {
      var parent = widget.containerWidget as Wrap;
      _renderWidget = Wrap(
        alignment: parent.alignment,
        crossAxisAlignment: parent.crossAxisAlignment,
        runAlignment: parent.runAlignment,
        spacing: parent.spacing,
        runSpacing: parent.runSpacing,
        direction: parent.direction,
        verticalDirection: parent.verticalDirection,
        clipBehavior: parent.clipBehavior,
        textDirection: parent.textDirection,
        children: _renderChildren(),
      );
    }
    return Container(width: double.infinity, child: _renderWidget);
  }

  List<Widget> _renderChildren() {
    return List.generate(
        widget.items.length,
        (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedItem = widget.items[index];
              });
              _onSelectedChange(
                index,
              );
            },
            child: widget.radioBuilder(
                index, widget.items[index], _selectedItem)));
  }
}
