import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MyHelper {
  static String formatDate(DateTime dateTime) {
    initializeDateFormatting("id");
    return DateFormat.yMMMMd("id").format(dateTime);
  }
}
