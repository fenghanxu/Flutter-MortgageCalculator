import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class Jailbreak {
  static const _platform = MethodChannel('com.example.jailbreak'); // iOS原生通道

  /// 主检测入口
  static Future<bool> isJailBreak() async {
    if (await _isSimulator()) return true;
    if (await _isJailBreakWithFile()) return true;
    if (await _isJailBreakWithOpenCydia()) return true;
    if (await _isJailBreakWithPath()) return true;
    if (await _isJailBreakWithReadAppList()) return true;
    return false;
  }

  /// 检查模拟器
  static Future<bool> _isSimulator() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    final name = iosInfo.name?.toLowerCase() ?? '';
    return name.contains('simulator') || !Platform.isIOS;
  }

  /// 检查常见越狱文件
  static Future<bool> _isJailBreakWithFile() async {
    final List<String> paths = [
      '/Applications/Cydia.app',
      '/Library/MobileSubstrate/MobileSubstrate.dylib',
      '/bin/bash',
      '/usr/sbin/sshd',
      '/etc/apt',
    ];

    for (final path in paths) {
      if (File(path).existsSync()) {
        return true;
      }
    }
    return false;
  }

  /// 检查能否打开 Cydia
  static Future<bool> _isJailBreakWithOpenCydia() async {
    final uri = Uri.parse('cydia://package/com.example.package');
    return await canLaunchUrl(uri);
  }

  /// 检查能否访问系统级目录
  static Future<bool> _isJailBreakWithReadAppList() async {
    try {
      final dir = Directory('/User/Applications/');
      return dir.existsSync();
    } catch (_) {
      return false;
    }
  }

  /// 检查环境变量（需要iOS原生支持）
  static Future<bool> _isJailBreakWithPath() async {
    try {
      final result = await _platform.invokeMethod('isJailBreakWithPath');
      return result == true;
    } catch (_) {
      return false;
    }
  }
}
