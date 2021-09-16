import 'package:intl/intl.dart';

class DataUtils {
  static fromHHMMSStoHHMM(String input) {
    var date = DateFormat('HH:mm').parse(input);
    return DateFormat('kk:mm').format(date);
  }

  static num moneyFormatToNum(String input, String moneyUnit) {
    if (input.isNotEmpty) {
      return num.parse(input
          .replaceAll(moneyUnit, '')
          .replaceAll('.', '')
          .replaceAll(',', ''));
    }
    return 0;
  }
}
