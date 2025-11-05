import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ClearCacheManager {
  // 单例
  ClearCacheManager._internal();
  static final ClearCacheManager _instance = ClearCacheManager._internal();
  factory ClearCacheManager() => _instance;

  /// 获取缓存目录路径
  Future<Directory> _getCacheDir() async {
    return await getTemporaryDirectory(); // 对应 iOS 的 NSCachesDirectory
  }

  /// 获取缓存大小（单位：MB）
  Future<double> getCacheSize() async {
    final dir = await _getCacheDir();
    int totalBytes = await _getDirectorySize(dir);
    return totalBytes / (1024 * 1024); // 转为 MB
  }

  /// 递归计算文件夹大小（字节数）
  Future<int> _getDirectorySize(FileSystemEntity entity) async {
    if (entity is File) {
      try {
        return await entity.length();
      } catch (_) {
        return 0;
      }
    }
    if (entity is Directory) {
      int total = 0;
      try {
        final children = entity.listSync();
        for (var child in children) {
          total += await _getDirectorySize(child);
        }
      } catch (_) {}
      return total;
    }
    return 0;
  }

  /// 清除缓存
  Future<void> removeCache() async {
    final dir = await _getCacheDir();
    if (await dir.exists()) {
      try {
        final children = dir.listSync();
        for (var child in children) {
          try {
            if (child is File) {
              await child.delete();
            } else if (child is Directory) {
              await child.delete(recursive: true);
            }
          } catch (_) {}
        }
      } catch (_) {}
    }
  }
}
