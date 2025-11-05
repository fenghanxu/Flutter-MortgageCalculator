import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:http/http.dart' as http;

class ImageSize {
  static Future<({int width, int height})?> getImageSize(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final extension = uri.path.split('.').last.toLowerCase();
    if (extension.contains('png')) {
      return await _getPngSize(uri);
    } else if (extension.contains('gif')) {
      return await _getGifSize(uri);
    } else if (extension.contains('jpg') || extension.contains('jpeg')) {
      return await _getJpgSize(uri);
    } else {
      return await _getImageSizeByFullDownload(uri);
    }
  }

  static Future<({int width, int height})?> _getPngSize(Uri uri) async {
    try {
      final response = await http.get(uri, headers: {'Range': 'bytes=16-23'});
      if (response.statusCode == 206 || response.statusCode == 200) {
        final data = response.bodyBytes;
        if (data.length == 8) {
          final width = _readUint32(data, 0);
          final height = _readUint32(data, 4);
          return (width: width, height: height);
        }
      }
    } catch (_) {}
    return null;
  }

  static Future<({int width, int height})?> _getGifSize(Uri uri) async {
    try {
      final response = await http.get(uri, headers: {'Range': 'bytes=6-9'});
      if (response.statusCode == 206 || response.statusCode == 200) {
        final data = response.bodyBytes;
        if (data.length == 4) {
          final width = _readUint16(data, 0);
          final height = _readUint16(data, 2);
          return (width: width, height: height);
        }
      }
    } catch (_) {}
    return null;
  }

  static Future<({int width, int height})?> _getJpgSize(Uri uri) async {
    try {
      final response = await http.get(uri, headers: {'Range': 'bytes=0-209'});
      if (response.statusCode == 206 || response.statusCode == 200) {
        final data = response.bodyBytes;
        if (data.length < 210) return null;

        int offset = 0;
        while (offset < data.length - 9) {
          if (data[offset] == 0xFF &&
              (data[offset + 1] >= 0xC0 && data[offset + 1] <= 0xC3)) {
            final height = (data[offset + 5] << 8) + data[offset + 6];
            final width = (data[offset + 7] << 8) + data[offset + 8];
            return (width: width, height: height);
          }
          offset++;
        }
      }
    } catch (_) {}
    return null;
  }

  /// ✅ 修正后的版本（Flutter 3.22+）
  static Future<({int width, int height})?> _getImageSizeByFullDownload(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // 使用 Completer 等待回调完成
        final completer = Completer<({int width, int height})>();

        ui.decodeImageFromList(bytes, (ui.Image img) {
          completer.complete((width: img.width, height: img.height));
        });

        return completer.future;
      }
    } catch (_) {}
    return null;
  }

  static int _readUint32(Uint8List data, int offset) {
    return (data[offset] << 24) |
    (data[offset + 1] << 16) |
    (data[offset + 2] << 8) |
    (data[offset + 3]);
  }

  static int _readUint16(Uint8List data, int offset) {
    return data[offset] + (data[offset + 1] << 8);
  }
}
