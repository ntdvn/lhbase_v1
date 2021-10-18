import 'package:flutter/material.dart';

typedef MultiChildRenderObjectWidget LhRadiosContainerBuilder();
typedef Widget LhRadiosWidgetBuilder<T>(int index, T item, T? selected);
typedef void LhRadiosOnSelectedChanged<T>(int index, T selected);

class LhRadiosWidget<T> extends StatefulWidget {
  final int? initialIndex;
  final List<T> items;
  // final List<T>? selectedItem;
  final LhRadiosWidgetBuilder<T> radioBuilder;
  final LhRadiosOnSelectedChanged<T>? onSelectedChanged;
  final LhRadiosContainerBuilder? containerBuilder;
  final Axis? scrollDirection;
  const LhRadiosWidget(
      {Key? key,
      required this.items,
      // this.selectedItem,
      required this.radioBuilder,
      this.onSelectedChanged,
      this.initialIndex,
      this.containerBuilder,
      this.scrollDirection})
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
      print('widget.initialIndex ${widget.initialIndex}');
      _selectedItem = widget.items[widget.initialIndex!];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget _renderWidget;
    if (widget.containerBuilder != null) {
      var parent = widget.containerBuilder!();

      if (parent is Column) {
        _renderWidget = Column(
          mainAxisAlignment: parent.mainAxisAlignment,
          crossAxisAlignment: parent.crossAxisAlignment,
          mainAxisSize: parent.mainAxisSize,
          verticalDirection: parent.verticalDirection,
          textDirection: parent.textDirection,
          textBaseline: parent.textBaseline,
          children: _renderChildren(),
        );
      } else if (parent is Row) {
        _renderWidget = Row(
          mainAxisAlignment: parent.mainAxisAlignment,
          crossAxisAlignment: parent.crossAxisAlignment,
          mainAxisSize: parent.mainAxisSize,
          verticalDirection: parent.verticalDirection,
          textDirection: parent.textDirection,
          textBaseline: parent.textBaseline,
          children: _renderChildren(),
        );
      } else if (parent is Wrap) {
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
      } else {
        // _renderWidget = Column(
        //   mainAxisAlignment: parent.mainAxisAlignment,
        //   crossAxisAlignment: parent.crossAxisAlignment,
        //   mainAxisSize: parent.mainAxisSize,
        //   verticalDirection: parent.verticalDirection,
        //   textDirection: parent.textDirection,
        //   textBaseline: parent.textBaseline,
        //   children: _renderChildren(),
        // );
      }
    }

    return _renderWidget;
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
