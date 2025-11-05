import 'package:flutter/widgets.dart';

class ScreenUtil {
  /// 判断是否为刘海屏（true 表示刘海屏，false 表示非刘海屏）
  static bool isNotchScreen(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    // 通常顶部安全区大于 20，就说明是刘海屏
    return padding.top > 20;
  }

  /// 如果你希望和原 OC 逻辑保持一致（YES = 非刘海屏）
  static bool isNotNotchScreen(BuildContext context) {
    return !isNotchScreen(context);
  }
}
