import 'dart:async';

/// 倒计时与顺计时工具类 (等价于 OC 的 CountDownManager)
class CountDownManager {
  Timer? _timer;

  /// 主动销毁定时器
  void destroyTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// 倒计时 (秒级时间戳)
  /// [finishTimeStamp] 结束时间戳（10位，单位秒）
  /// [adjust] 校正时间（服务器与本地的时间差，单位秒）
  /// [onTick] 每秒回调，返回时间字符串与是否结束
  void countDownWithFinishTimeStamp(
      int finishTimeStamp, {
        double adjust = 0,
        required void Function(String timeStr, bool isFinish) onTick,
      }) {
    final now = DateTime.now().millisecondsSinceEpoch / 1000 + adjust;
    final remaining = finishTimeStamp - now;
    _countDownWithTimeout(remaining.toInt(), onTick);
  }

  /// 倒计时 (毫秒级时间戳)
  void countDownWithFinishTimeMillisecond(
      int finishTimeStamp, {
        double adjust = 0,
        required void Function(String timeStr, bool isFinish) onTick,
      }) {
    final now = DateTime.now().millisecondsSinceEpoch + adjust * 1000;
    final remaining = (finishTimeStamp - now) / 1000;
    _countDownWithTimeout(remaining.toInt(), onTick);
  }

  /// 顺计时 (秒级)
  void clockwiseHasPassTimeWithStartTimeStamp(
      int startTimeStamp, {
        double adjust = 0,
        required void Function(String dateStr) onTick,
      }) {
    destroyTimer();
    final now = DateTime.now().millisecondsSinceEpoch / 1000 + adjust;
    int elapsed = (now - startTimeStamp).toInt();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsed++;
      onTick(_formatTime(elapsed));
    });
  }

  /// 顺计时 (毫秒级)
  void clockwiseHasPassTimeWithStartTimeMillisecond(
      int startTimeStamp, {
        double adjust = 0,
        required void Function(String dateStr) onTick,
      }) {
    destroyTimer();
    final now = DateTime.now().millisecondsSinceEpoch + adjust * 1000;
    int elapsed = ((now - startTimeStamp) / 1000).toInt();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsed++;
      onTick(_formatTime(elapsed));
    });
  }

  /// 从开始时间到结束时间递增 (秒级)
  void countDownHasPassTimeWithStartAndFinishTimeStamp(
      int startTimeStamp,
      int finishTimeStamp, {
        double adjust = 0,
        required void Function(String dateStr, bool isFinish) onTick,
      }) {
    destroyTimer();
    final now = DateTime.now().millisecondsSinceEpoch / 1000 + adjust;
    int elapsed = (now - startTimeStamp).toInt();
    final total = finishTimeStamp - startTimeStamp;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final isFinish = elapsed >= total;
      onTick(_formatTime(elapsed), isFinish);
      if (isFinish) {
        destroyTimer();
      } else {
        elapsed++;
      }
    });
  }

  /// 从开始时间到结束时间递增 (毫秒级)
  void countDownHasPassTimeWithStartAndFinishTimeMillisecond(
      int startTimeStamp,
      int finishTimeStamp, {
        double adjust = 0,
        required void Function(String dateStr, bool isFinish) onTick,
      }) {
    destroyTimer();
    final now = DateTime.now().millisecondsSinceEpoch + adjust * 1000;
    int elapsed = ((now - startTimeStamp) / 1000).toInt();
    final total = ((finishTimeStamp - startTimeStamp) / 1000).toInt();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final isFinish = elapsed >= total;
      onTick(_formatTime(elapsed), isFinish);
      if (isFinish) {
        destroyTimer();
      } else {
        elapsed++;
      }
    });
  }

  /// 倒计时（直接输入秒数）
  void _countDownWithTimeout(
      int timeout,
      void Function(String timeStr, bool isFinish) onTick,
      ) {
    destroyTimer();
    int remaining = timeout;
    if (remaining <= 0) {
      onTick(_formatTime(0), true);
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining <= 0) {
        destroyTimer();
        onTick(_formatTime(0), true);
      } else {
        onTick(_formatTime(remaining), false);
        remaining--;
      }
    });
  }

  /// 获取当前时间戳（秒级）
  static String getNowTimeTimestampSecond() {
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  }

  /// 获取当前时间戳（毫秒级）
  static String getNowTimeTimestampMillisecond() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 内部工具：格式化输出 "dd:HH:mm:ss"
  String _formatTime(int seconds) {
    int days = seconds ~/ (3600 * 24);
    int hours = (seconds % (3600 * 24)) ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(days)}:${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(secs)}";
  }
}
