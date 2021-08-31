import 'package:intl/intl.dart';

class Helpers {
  static DateFormat _dateFormat = DateFormat("d MMMM y", 'ru-RU');

  static formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

}