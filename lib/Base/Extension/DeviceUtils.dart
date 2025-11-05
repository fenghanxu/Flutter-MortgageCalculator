import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  /// 屏幕宽度
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// 屏幕高度
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// 状态栏高度
  static double statusHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  /// 底部安全距离（适配 iPhone X 等刘海屏）
  static double bottomSafeHeight(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  /// 导航栏高度 (Flutter 没有原生导航栏，通常自己定义 AppBar 高度)
  static double navigationHeight = kToolbarHeight;

  /// tabbar 高度（49），刘海屏加上底部安全区
  static double tabBarHeight(BuildContext context) =>
      49 + bottomSafeHeight(context);

  /// 顶部安全距离
  static double topSafeHeight(BuildContext context) =>
      statusHeight(context) + navigationHeight;

  /// 是否是刘海屏
  static bool isNotchScreen(BuildContext context) =>
      bottomSafeHeight(context) > 0;

  /// iOS/Android 系统版本
  static String osVersion() => Platform.operatingSystemVersion;

  /// App 版本号
  static Future<String?> appVersion() async {
    // 用 package_info_plus 获取
    // import 'package:package_info_plus/package_info_plus.dart';
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  /// Debug 打印
  static void debugLog(String msg) {
    if (kDebugMode) {
      // kDebugMode 在 debug 模式下为 true，release 下自动去掉
      debugPrint('[DEBUG] $msg');
    }
  }
}
