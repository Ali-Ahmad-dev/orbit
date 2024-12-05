import 'package:intl/intl.dart';

class HrDatetimeUtil{

  static String toMinAndSecond(String date){
    return DateFormat('mm:ss').format(DateTime.parse(date));
  }

  static String toHourAndMin(String date){
    return DateFormat('HH:mm a').format(DateTime.parse(date));
  }

  static String toYearMonthDay(String date){
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  static String toYearMonthDayTime(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(date));
  }
}