import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/widgets/view_list_image_screen.dart';
import 'package:lhbase_v1/lhbase.dart';

class ChatImages extends StatelessWidget {
  final ChatMessage message;
  final DateTime time;
  const ChatImages({Key? key, required this.message, required this.time}) : super(key: key);

  static const crossAxisCell = 6;
  static const realCrossAxisCell = crossAxisCell / 2;

  @override
  Widget build(BuildContext context) {
    return message.is_hidden == false ? Stack(
      children: [
        Container(
          // width: 250,
          color: Colors.white,
          child: message.imageUrls!.length > 1
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: crossAxisCell,
                  itemCount: message.imageUrls!.length,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          print('index $index');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewListNetworkImageScreen(listImage: message.imageUrls!, initIndex: index,)
                            ),
                          );
                        },
                        child: WidgetNetworkImage(
                          image: message.imageUrls![index],
                          borderRadius: 4,
                          fit: BoxFit.cover,
                        )
                    )
                    ;
                  },
                  staggeredTileBuilder: (index) {
                    return new StaggeredTile.count(
                        getCrossAxisCell(index), getMainAxisCell(index));
                  },
                )
              : FractionallySizedBox(
                  widthFactor: .7,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewListNetworkImageScreen(listImage: message.imageUrls!, initIndex: 0,)
                        ),
                      );
                    },
                    child: Image.network(
                      message.imageUrls![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: LhText(LhValue.dateTimeToTime(time), style: LhStyle.DEFAULT_12.copyWith(color: Colors.black),),
          ),
        )
      ],
    ) : GetBuilder<ChatKitController>(
      builder: (controller) {
        return Container(
          color: Colors.transparent,
          key: UniqueKey(),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: controller.user == message.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                'Tin nhắn đã được thu hồi',
                style: controller.user == message.user
                    ? controller.themeData.textMessageThemeData.textStyle
                    : controller.themeData.mTextMessageThemeData.textStyle,
                textAlign: TextAlign.start,
                softWrap: true,
                maxLines: null,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: LhText(LhValue.dateTimeToTime(time), style: LhStyle.DEFAULT_12.copyWith(color: Colors.grey[100]),),
              )
            ],
          ),
        );
      },
    );
  }

  int getCrossAxisCell(int index) {
    var indexCount = index + 1;
    var rowFill = message.imageUrls!.length ~/ realCrossAxisCell;

    var rowNotFill = message.imageUrls!.length % realCrossAxisCell;
    if (indexCount <= realCrossAxisCell * rowFill)
      return 2;
    else
      return crossAxisCell ~/ rowNotFill;
  }

  double getMainAxisCell(int index) {
    var indexCount = index + 1;
    var rowFill = message.imageUrls!.length ~/ realCrossAxisCell;
    if (indexCount <= realCrossAxisCell * rowFill)
      return 1.75;
    else
      return 3;
  }
}
