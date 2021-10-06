import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/common/routes/app_pages.dart';

class ExamplesPage extends StatelessWidget {
  const ExamplesPage({Key? key}) : super(key: key);

  static final pages = AppPages().routes;

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(),
        child: Column(
          children: List.generate(
              pages.length,
              (index) => TextButton(
                  onPressed: () {
                    Get.toNamed(pages[index].name);
                  },
                  child: Text(pages[index].name))),
        ));
  }
}
