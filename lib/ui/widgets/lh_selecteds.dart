import 'package:flutter/material.dart';

typedef Widget LhSelectedAddBuilder();
typedef BoxScrollView LhSelectedContainerBuilder();
typedef Widget LhSelectedBuilder<B>(int index, B item);
typedef Widget LhSelectedRemoveBuilder<B>(int index, B item);

enum LhAddPosition { FIRST, END }

class LhSelecteds<B> extends StatefulWidget {
  final List<B>? initialValue;
  final LhSelectedContainerBuilder? containerBuilder;
  final LhAddPosition addPosition;
  final LhSelectedAddBuilder? addBuilder;
  final LhSelectedBuilder<B> builder;
  final LhSelectedRemoveBuilder<B> removeBuilder;
  const LhSelecteds(
      {Key? key,
      this.initialValue,
      this.addPosition = LhAddPosition.FIRST,
      this.addBuilder,
      this.containerBuilder,
      required this.builder,
      required this.removeBuilder})
      : super(key: key);

  @override
  _LhSelectedsState createState() => _LhSelectedsState<B>();
}

class _LhSelectedsState<B> extends State<LhSelecteds<B>> {
  late List<B> _selecteds;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _selecteds = widget.initialValue!;
    } else {
      _selecteds = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _builderContainer();
  }

  Widget _builderContainer() {
    var _renderResult;
    if (widget.containerBuilder != null) {
      var container = widget.containerBuilder!();
      if (container is ListView) {
        if (container.scrollDirection == Axis.horizontal) {
          _renderResult = SingleChildScrollView(
            scrollDirection: container.scrollDirection,
            child: Row(
              children: [..._buildListWithAddButton()],
            ),
          );
        } else {
          _renderResult = SingleChildScrollView(
            scrollDirection: container.scrollDirection,
            child: Column(
              children: [..._buildListWithAddButton()],
            ),
          );
        }
      } else if (container is GridView) {
        _renderResult = GridView(
          scrollDirection: container.scrollDirection,
          physics: container.physics,
          shrinkWrap: container.shrinkWrap,
          gridDelegate: container.gridDelegate,
          children: [..._buildListWithAddButton()],
        );
      }
    } else {
      _renderResult = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [..._buildListWithAddButton()],
        ),
      );
    }
    return _renderResult;
  }

  List<Widget> _buildSelecteds() {
    return List.generate(_selecteds.length, (index) {
      return Stack(
        children: [
          widget.builder(index, _selecteds[index]),
          Positioned.fill(child: widget.removeBuilder(index, _selecteds[index]))
        ],
      );
    });
  }

  List<Widget> _buildListWithAddButton() {
    var _renderAddButton;
    if (widget.addBuilder != null) {
      _renderAddButton = widget.addBuilder!();
      return [
        if (widget.addPosition == LhAddPosition.FIRST) _renderAddButton,
        ..._buildSelecteds(),
        if (widget.addPosition == LhAddPosition.END) _renderAddButton,
      ];
    } else {
      return [..._buildSelecteds()];
    }
  }
}
