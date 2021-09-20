import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalConfigController extends GetxController {
  RxString _fontFamily = RxString('Inter');

  String get fontFamily => _fontFamily.value;
  set fontFamily(String fontFamily) {
    _fontFamily.value = fontFamily;
  }
}
