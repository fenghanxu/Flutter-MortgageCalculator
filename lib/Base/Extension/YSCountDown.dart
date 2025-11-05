import 'dart:async';
import 'package:flutter/foundation.dart';

typedef YSCountDownCallback = void Function(int index);

class YSCountDown {
  final YSCountDownCallback? onFinish;
  Timer? _timer;
  int _less = 0;
  bool isPlusTime = false;

  List<int>? _dataList; // 结束时间戳
  List<String>? _canReloadList; // “可以” / “不可以”
  ValueNotifier<int> _tick = ValueNotifier(0);
  ValueNotifier<int> get tick => _tick; // 公有 getter

  YSCountDown({this.onFinish});

  void destroyTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// 初始化
  void init({
    required List<int> dataList,
    required List<String> canReloadList,
  }) {
    _dataList = dataList;
    _canReloadList = canReloadList;
    _setupLess();
  }

  void _setupLess() async {
    // TODO: 可扩展：请求服务器时间差
    _less = 0;
    _startTimer();
  }

  void _startTimer() {
    destroyTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick.value++; // 通知监听者
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    if (_dataList == null || _canReloadList == null) return;

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    for (int i = 0; i < _dataList!.length; i++) {
      final end = _dataList![i] + _less;
      final text = getNowTimeWithString(end, now);
      if (text == "倒计时结束" && _canReloadList![i] == "可以") {
        _canReloadList![i] = "不可以";
        onFinish?.call(i);
      }
    }
  }

  /// cell 滑动过快时调用
  String getCountdownText(int index) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final endTime = _dataList![index] + _less;
    return getNowTimeWithString(endTime, now);
  }

  /// 时间计算逻辑
  String getNowTimeWithString(int endTime, int currentTime) {
    int interval = endTime - currentTime;

    int days = interval ~/ (3600 * 24);
    int hours = (interval - days * 24 * 3600) ~/ 3600;
    int minutes = (interval - days * 24 * 3600 - hours * 3600) ~/ 60;
    int seconds =
        interval - days * 24 * 3600 - hours * 3600 - minutes * 60;

    if (isPlusTime) {
      if (hours >= 0 && minutes >= 0 && seconds >= 0) {
        return "正在倒计时";
      }
      hours = -hours;
      minutes = -minutes;
      seconds = -seconds;
    } else {
      if (hours <= 0 && minutes <= 0 && seconds <= 0) {
        return "倒计时结束";
      }
    }

    if (days > 0) {
      return "${days.toString().padLeft(2, '0')} : ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
    } else {
      return "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
    }
  }
}

/*
* 使用
import 'package:flutter/material.dart';
import 'ys_count_down.dart'; // 上面类

class CountDownListPage extends StatefulWidget {
  const CountDownListPage({super.key});

  @override
  State<CountDownListPage> createState() => _CountDownListPageState();
}

class _CountDownListPageState extends State<CountDownListPage> {
  late YSCountDown countDown;
  List<int> dataList = [];
  List<String> canReloadList = [];

  @override
  void initState() {
    super.initState();

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // 模拟3个未来倒计时 30s、60s、90s
    dataList = [now + 30, now + 60, now + 90];
    canReloadList = ["可以", "可以", "可以"];

    countDown = YSCountDown(onFinish: (index) {
      debugPrint("Cell $index 倒计时结束，刷新页面");
      setState(() {});
    });

    countDown.init(dataList: dataList, canReloadList: canReloadList);
  }

  @override
  void dispose() {
    countDown.destroyTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("倒计时列表")),
      body: ValueListenableBuilder(
        valueListenable: countDown._tick,
        builder: (context, _, __) {
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final text = countDown.getCountdownText(index);
              return ListTile(
                leading: Text("商品 $index"),
                title: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

* */
