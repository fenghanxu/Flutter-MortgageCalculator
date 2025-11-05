import 'package:flutter/material.dart';

class IOSDeviceCheck {
  static Size _physicalSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Size(
      mq.size.width * mq.devicePixelRatio,
      mq.size.height * mq.devicePixelRatio,
    );
  }

  static bool isIphone5(BuildContext context) =>
      _equalSize(context, const Size(640, 1136));

  static bool isIphone5S(BuildContext context) =>
      _equalSize(context, const Size(640, 1136));

  static bool isIphone5C(BuildContext context) =>
      _equalSize(context, const Size(640, 1136));

  static bool isIphoneSE(BuildContext context) =>
      _equalSize(context, const Size(640, 1136));

  static bool isIphoneSE2(BuildContext context) =>
      _equalSize(context, const Size(750, 1334));

  static bool isIphone6(BuildContext context) =>
      _equalSize(context, const Size(750, 1334));

  static bool isIphone6S(BuildContext context) =>
      _equalSize(context, const Size(750, 1334));

  static bool isIphone7(BuildContext context) =>
      _equalSize(context, const Size(750, 1334));

  static bool isIphone8(BuildContext context) =>
      _equalSize(context, const Size(750, 1334));

  static bool isIphone6Plus(BuildContext context) =>
      _equalSize(context, const Size(1242, 2208));

  static bool isIphone6SPlus(BuildContext context) =>
      _equalSize(context, const Size(1242, 2208));

  static bool isIphone7Plus(BuildContext context) =>
      _equalSize(context, const Size(1242, 2208));

  static bool isIphone8Plus(BuildContext context) =>
      _equalSize(context, const Size(1242, 2208));

  static bool isIphoneX(BuildContext context) =>
      _equalSize(context, const Size(1125, 2436));

  static bool isIphoneXR(BuildContext context) =>
      _equalSize(context, const Size(828, 1792));

  static bool isIphoneXS(BuildContext context) =>
      _equalSize(context, const Size(1125, 2436));

  static bool isIphoneXSMax(BuildContext context) =>
      _equalSize(context, const Size(1242, 2688));

  static bool isIphone11(BuildContext context) =>
      _equalSize(context, const Size(828, 1792));

  static bool isIphone11Pro(BuildContext context) =>
      _equalSize(context, const Size(1125, 2436));

  static bool isIphone11ProMax(BuildContext context) =>
      _equalSize(context, const Size(1242, 2688));

  static bool isIphone12(BuildContext context) =>
      _equalSize(context, const Size(1170, 2532));

  static bool isIphone12Pro(BuildContext context) =>
      _equalSize(context, const Size(1170, 2532));

  static bool isIphone12ProMax(BuildContext context) =>
      _equalSize(context, const Size(1284, 2778));

  static bool isIphone12Mini(BuildContext context) =>
      _equalSize(context, const Size(1080, 2340));

  static bool isIphone13(BuildContext context) =>
      _equalSize(context, const Size(1170, 2532));

  static bool isIphone13Pro(BuildContext context) =>
      _equalSize(context, const Size(1170, 2532));

  static bool isIphone13ProMax(BuildContext context) =>
      _equalSize(context, const Size(1284, 2778));

  static bool isIphone13Mini(BuildContext context) =>
      _equalSize(context, const Size(1080, 2340));

  /// 工具方法：对比物理分辨率
  static bool _equalSize(BuildContext context, Size target) {
    final actual = _physicalSize(context);
    return actual.width.round() == target.width.round() &&
        actual.height.round() == target.height.round();
  }
}
