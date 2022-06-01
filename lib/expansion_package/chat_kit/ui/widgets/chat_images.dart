import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ChatImages extends StatelessWidget {
  final List<String> imageUrls;
  const ChatImages({Key? key, required this.imageUrls}) : super(key: key);

  static const crossAxisCell = 6;
  static const realCrossAxisCell = crossAxisCell / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      color: Colors.white,
      child: imageUrls.length > 1
          ? StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: crossAxisCell,
              itemCount: imageUrls.length,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      print('index $index');
                    },
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ));
              },
              staggeredTileBuilder: (index) {
                return new StaggeredTile.count(
                    getCrossAxisCell(index), getMainAxisCell(index));
              },
            )
          : FractionallySizedBox(
              widthFactor: .7,
              child: Image.network(
                imageUrls[0],
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  int getCrossAxisCell(int index) {
    var indexCount = index + 1;
    var rowFill = imageUrls.length ~/ realCrossAxisCell;

    var rowNotFill = imageUrls.length % realCrossAxisCell;
    if (indexCount <= realCrossAxisCell * rowFill)
      return 2;
    else
      return crossAxisCell ~/ rowNotFill;
  }

  double getMainAxisCell(int index) {
    var indexCount = index + 1;
    var rowFill = imageUrls.length ~/ realCrossAxisCell;
    if (indexCount <= realCrossAxisCell * rowFill)
      return 1.75;
    else
      return 3;
  }
}
