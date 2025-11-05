import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QRCodeUtil {
  /// 生成二维码 Widget
  /// [qrString] 内容
  /// [size] 图片大小
  /// [color] 填充颜色
  static Widget createQRImageString(
      String qrString, double size, Color color) {
    return QrImageView(
      data: qrString,
      version: QrVersions.auto,
      size: size,
      foregroundColor: color,
      backgroundColor: Colors.white,
    );
  }

  /// 将二维码图片转成 Uint8List（类似 UIImage）
  static Future<Uint8List?> createQRImageBytes(
      String qrString, double size, Color color) async {
    final painter = QrPainter(
      data: qrString,
      version: QrVersions.auto,
      gapless: true,
      color: color,
      emptyColor: Colors.white,
    );
    final picData = await painter.toImageData(size);
    return picData?.buffer.asUint8List();
  }

  /// 从图片文件路径中读取二维码信息
  static Future<String?> readQRCodeFromFile(String filePath) async {
    try {
      String? result = await QrCodeToolsPlugin.decodeFrom(filePath);
      return result;
    } catch (e) {
      debugPrint("二维码解析失败: $e");
      return null;
    }
  }

  /// 从 Uint8List（内存中的图片数据）读取二维码信息
  static Future<String?> readQRCodeFromBytes(Uint8List data) async {
    try {
      // 1. 获取临时目录
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp_qr.png');

      // 2. 写入临时文件
      await file.writeAsBytes(data);

      // 3. 调用 decodeFrom() 解析
      String? result = await QrCodeToolsPlugin.decodeFrom(file.path);
      return result;
    } catch (e) {
      debugPrint("二维码解析失败: $e");
      return null;
    }
  }
}
