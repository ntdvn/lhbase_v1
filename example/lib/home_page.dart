import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('_HomePageState');
    super.initState();
  }

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          title: 'abc',
          titleStyle: TextStyle(color: Colors.white),
        ),
        child: Center(
            child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: LhText('Login Page'),
            ),
            _renderSearchTextField(),
            Container(
              // height: 115,
              // width: 115,
              child: LhAvatar(
                  borderWidth: 1,
                  onDelete: () {
                    print('onDelete');
                  },
                  onEdit: () {
                    print('onEdit');
                  },
                  height: 120,
                  width: 120,
                  isOnline: true,
                  imageUrl:
                      'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg'),
            )
          ],
        )));
  }

  Widget _renderSearchTextField() {
    return Container(
        color: Colors.blue,
        child: LhInputSearch(
          controller: controller,
          // hint: 'chat_main.search'.tr,
        ));
  }
}
