import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';

class ImageWaterMark {
  /// 图片加图片水印（指定位置和透明度）
  static Future<ui.Image> imageWaterMarkWithImage(
      ui.Image baseImage,
      ui.Image watermark,
      Offset point,
      double alpha,
      ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制原图
    canvas.drawImage(baseImage, Offset.zero, Paint());

    // 绘制水印
    final paint = Paint()..color = Colors.white.withOpacity(alpha);
    canvas.drawImage(watermark, point, paint);

    final picture = recorder.endRecording();
    return picture.toImage(baseImage.width, baseImage.height);
  }

  /// 图片加文字水印（指定位置和属性）
  static Future<ui.Image> imageWaterMarkWithString(
      ui.Image baseImage,
      String text,
      Offset point,
      TextStyle style,
      ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制原图
    canvas.drawImage(baseImage, Offset.zero, Paint());

    // 绘制文字
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(); // 计算文字大小
    textPainter.paint(canvas, point);

    final picture = recorder.endRecording();
    return picture.toImage(baseImage.width, baseImage.height);
  }

  /// 图片加文字和图片水印（指定位置和透明度）
  static Future<ui.Image> imageWaterMarkWithStringAndImage(
      ui.Image baseImage,
      {String? text,
        Offset? textPoint,
        TextStyle? textStyle,
        ui.Image? watermark,
        Offset? imagePoint,
        double alpha = 1.0}) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制原图
    canvas.drawImage(baseImage, Offset.zero, Paint());

    // 绘制水印图片
    if (watermark != null && imagePoint != null) {
      final paint = Paint()..color = Colors.white.withOpacity(alpha);
      canvas.drawImage(watermark, imagePoint, paint);
    }

    // 绘制文字
    if (text != null && textPoint != null && textStyle != null) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, textPoint);
    }

    final picture = recorder.endRecording();
    return picture.toImage(baseImage.width, baseImage.height);
  }

  /// 将ui.Image转成Uint8List（方便保存或展示）
  static Future<Uint8List> imageToBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
