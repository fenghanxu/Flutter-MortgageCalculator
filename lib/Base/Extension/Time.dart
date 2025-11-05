import 'package:intl/intl.dart';

/// 时间工具类
class Time {
  /// 获取当前时间字符串
  /// [type] 格式：如 "yyyy-MM-dd HH:mm:ss SSS"、"yyyy-MM-dd"、"MM-dd" 等
  static String getCurrentTimesWithType(String type) {
    final now = DateTime.now();
    final formatter = DateFormat(type);
    return formatter.format(now);
  }

  /// 获取当前时间戳（秒）——方法A
  static String getNowTimeTimestampSecondA() {
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  }

  /// 获取当前时间戳（秒）——方法B
  static String getNowTimeTimestampSecondB() {
    final seconds = DateTime.now().millisecondsSinceEpoch / 1000;
    return seconds.toStringAsFixed(0);
  }

  /// 获取当前时间戳（毫秒）
  static String getNowTimeTimestampMillisecond() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
