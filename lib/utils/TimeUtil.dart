class TimeUtil {
  static String timerFormat(String t) {
    var d1 = DateTime.parse('2018-10-10 09:30:30Z');
    return '${d1.year}年${d1.month}月${d1.day}日';
  }
}
