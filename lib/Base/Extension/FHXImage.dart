import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class FHXImage {
  /// 根据颜色生成 1x1 图片
  static Future<ui.Image> createImageWithColor(Color color) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(0, 0, 1, 1), paint);
    final picture = recorder.endRecording();
    // 注意：toImage 返回 Future<ui.Image>
    return await picture.toImage(1, 1);
  }

  /// 根据颜色和尺寸生成图片
  static Future<ui.Image> createImageWithColorAndRect(Color color, Size size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    final picture = recorder.endRecording();
    return await picture.toImage(size.width.toInt(), size.height.toInt());
  }

  /// 图片圆形化
  static Widget circleImage(ImageProvider imageProvider,
      {double? width, double? height}) {
    return ClipOval(
      child: Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 图片拉伸
  static Widget stretchableImage(ImageProvider imageProvider,
      {double? width, double? height}) {
    return Image(
      image: imageProvider,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }

  /// 加载本地 GIF
  static Image loadGif(String assetName, {double? width, double? height}) {
    return Image.asset(
      assetName,
      width: width,
      height: height,
    );
  }

  /// 加载网络 GIF
  static Image loadNetworkGif(String url, {double? width, double? height}) {
    return Image.network(
      url,
      width: width,
      height: height,
    );
  }
}
