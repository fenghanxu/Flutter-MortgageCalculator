import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class Sandbox {
  /// 获取 Documents 路径
  static Future<String> sandboxGetDocumentsPathWithName([String? name]) async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    if (name != null) {
      path = "${directory.path}${Platform.pathSeparator}$name";
    }
    log("filePath: $path");
    return path;
  }

  /// 获取 Caches 路径
  static Future<String> sandboxGetCachesPathWithName([String? name]) async {
    final directory = await getTemporaryDirectory(); // 注意: iOS/Android 上 caches 是临时目录
    String path = directory.path;
    if (name != null) {
      path = "${directory.path}${Platform.pathSeparator}$name";
    }
    log("filePath: $path");
    return path;
  }

  /// 获取 Tmp 路径
  static Future<String> sandboxGetTmpPathWithName([String? name]) async {
    final tmpPath = await getTemporaryDirectory();
    String path = tmpPath.path;
    if (name != null) {
      path = "${tmpPath.path}${Platform.pathSeparator}$name";
    }
    log("filePath: $path");
    return path;
  }
}
