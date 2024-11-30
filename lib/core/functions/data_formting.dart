import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _dateFormatter = DateFormat('yyyy/MM/dd');
  static final DateFormat _dateTimeFormatter = DateFormat('yyyy/MM/dd HH:mm');

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  static String formatDateTime(DateTime date) {
    return _dateTimeFormatter.format(date);
  }
}
