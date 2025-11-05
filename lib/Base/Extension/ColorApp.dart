import 'dart:math';
import 'package:flutter/material.dart';

/// 颜色工具类
class ColorHex {
  /// 将 0x 开头的十六进制值转换为 Color
  /// [ColorHex.fromHex(0xFF00CD)]
  static Color fromHexInt(int hexColor, {double alpha = 1.0}) {
    assert(alpha >= 0 && alpha <= 1);
    return Color.fromRGBO(
      (hexColor >> 16) & 0xFF,
      (hexColor >> 8) & 0xFF,
      hexColor & 0xFF,
      alpha,
    );
  }

  /// 从字符串（# 或 0x 开头）创建颜色
  /// 支持格式：
  /// - "#333333"
  /// - "0X333333"
  /// - "333333"
  static Color fromHexString(String colorStr) {
    String c = colorStr.trim().toUpperCase();

    if (c.startsWith('0X')) {
      c = c.substring(2);
    } else if (c.startsWith('#')) {
      c = c.substring(1);
    }

    if (c.length != 6) return Colors.transparent;

    final r = int.parse(c.substring(0, 2), radix: 16);
    final g = int.parse(c.substring(2, 4), radix: 16);
    final b = int.parse(c.substring(4, 6), radix: 16);

    return Color.fromRGBO(r, g, b, 1.0);
  }
}

/// 应用颜色表（等价于 OC 的 Color 类）
class ColorApp {
  /// 随机颜色
  static Color get random {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  /// 主题色
  static const Color theme = Color(0xFF3CB371);

  /// 亮主题色
  static const Color themeLight = Color(0xFF7FFFAA);

  /// 浅主题色
  static const Color themeShallow = Color(0xFFCFFFDD);

  /// 弱主题色
  static const Color themeWeak = Color(0xFFEBFFF5);

  /// 文字主题色
  static const Color textTheme = Color(0xFF010101);

  /// 文字主色
  static const Color textBlank = Color(0xFF333333);

  /// 二级文字
  static const Color textSub = Color(0xFF8C8C8C);

  /// 未激活按钮
  static const Color nonActivated = Color(0xFFBEBEBE);

  /// 文字描边
  static const Color textLine = Color(0xFFDDDDDD);

  /// 分割线
  static const Color line = Color(0xFFE5E5E5);

  /// 背景
  static const Color background = Color(0xFFF5F5F5);

  /// 辅助色
  static const Color assist = Color(0xFFFFAC03);

  /// 辅助深色
  static const Color assistDeep = Color(0xFFF4A400);

  /// 底部导航栏文字颜色
  static const Color tabbarTtitle = Color(0xFFa7a7a7);

}