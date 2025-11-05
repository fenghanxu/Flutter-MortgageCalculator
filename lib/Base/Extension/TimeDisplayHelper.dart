import 'package:intl/intl.dart';

class TimeDisplayHelper {
  static String wechatStyleTimeStringFromDate(DateTime? date, {String locale = 'zh_CN'}) {
    if (date == null) return '';

    final now = DateTime.now();
    final diff = now.difference(date);

    // 今天
    if (_isSameDay(now, date)) {
      if (diff.inSeconds < 60) return '刚刚';
      if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
      return DateFormat('HH:mm', locale).format(date);
    }

    // 昨天
    final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    if (_isSameDay(yesterday, date)) {
      return '昨天 ${DateFormat('HH:mm', locale).format(date)}';
    }

    // 本周内（周一为第一天）
    if (_isSameWeek(now, date)) {
      final weekdaySymbols = ['周一','周二','周三','周四','周五','周六','周日'];
      final weekdayStr = weekdaySymbols[date.weekday - 1]; // DateTime.weekday: Mon=1..Sun=7
      return '$weekdayStr ${DateFormat('HH:mm', locale).format(date)}';
    }

    // 今年内
    if (now.year == date.year) {
      return DateFormat('MM-dd HH:mm', locale).format(date);
    }

    // 更早
    return DateFormat('yyyy-MM-dd HH:mm', locale).format(date);
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool _isSameWeek(DateTime a, DateTime b) {
    final aStart = _startOfWeek(a);
    final bStart = _startOfWeek(b);
    return aStart.year == bStart.year && aStart.month == bStart.month && aStart.day == bStart.day;
  }

  // 以周一为每周的第一天
  static DateTime _startOfWeek(DateTime d) {
    final date = DateTime(d.year, d.month, d.day);
    return date.subtract(Duration(days: date.weekday - 1));
  }
}
