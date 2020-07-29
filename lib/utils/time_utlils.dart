import 'package:date_format/date_format.dart';

class TimeUtils {
  static String getCurrentDate() {
    DateTime dateTime = DateTime.now();
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  static String getCurrentTime() {
    DateTime dateTime = DateTime.now();

    return formatDate(dateTime, [HH, ':', nn, ':', ss]);
  }

  static String getDayString(int  time ,{format="yyyy-MM-dd hh:mm:ss"}) {
    if (time == null) {
      return "";
    } else {
      DateTime dateTime =DateTime.fromMillisecondsSinceEpoch(time*1000);

      return formatDate(
          dateTime, [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
    }
  }
  static String getChatTime(int  time ,{format="MM-dd hh:mm:ss"}) {
    if (time == null) {
      return "";
    } else {
      DateTime dateTime =DateTime.fromMillisecondsSinceEpoch(time*1000);

      return formatDate(
          dateTime, [ mm, "-", dd, " ", HH, ":", nn, ":", ss]);
    }
  }
  static String  parseString(int  time){
    if(time==null){
      return "";
    }else{
      DateTime parse = DateTime.fromMillisecondsSinceEpoch(time*1000);

      return  formatDate(parse ,[yyyy,'-',mm,'-',dd]);

    }

  }
}
