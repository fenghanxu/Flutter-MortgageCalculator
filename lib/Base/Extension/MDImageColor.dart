
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// 简单的 model，等同于你的 ImageColorModel
class ImageColorModel {
  final Color color;
  final int colorCount;
  final double alpha;

  ImageColorModel({
    required this.color,
    required this.colorCount,
    required this.alpha,
  });
}

class MDImageColor {
  /// 从图片字节（png/jpg bytes）计算主色（同步）
  /// 返回 null 表示无法解析图片或无有效像素
  static ImageColorModel? mostColorFromBytes(Uint8List bytes, {int thumbWidth = 40, int thumbHeight = 40}) {
    final src = img.decodeImage(bytes);
    if (src == null) return null;

    final thumb = img.copyResize(src, width: thumbWidth, height: thumbHeight);

    double maxScore = 0.0;
    List<int>? best; // [r,g,b,a]

    final int w = thumb.width;
    final int h = thumb.height;

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        final pixel = thumb.getPixel(x, y); // 返回 Pixel 对象
        final int red = pixel.r.toInt();
        final int green = pixel.g.toInt();
        final int blue = pixel.b.toInt();
        final int alpha = pixel.a.toInt();

        if (alpha < 25) continue;

        final hsv = _rgbToHsv(red.toDouble(), green.toDouble(), blue.toDouble());
        final double s = hsv[1];

        int yTemp = ((red * 2104 + green * 4130 + blue * 802 + 4096 + 131072) >> 13);
        if (yTemp > 235) yTemp = 235;
        double yVal = (yTemp - 16) / (235 - 16);
        if (yVal > 0.9) continue;

        final double index = (y * w + x).toDouble();
        final double score = (s + 0.1) * index;

        if (score > maxScore) {
          maxScore = score;
          best = [red, green, blue, alpha];
        }
      }
    }


    if (best == null) return null;

    final Color color = Color.fromARGB(best[3], best[0], best[1], best[2]);
    final int count = best[0] + best[1] + best[2];
    final double alpha = best[3] / 255.0;

    return ImageColorModel(color: color, colorCount: count, alpha: alpha);
  }

  /// 如果你已经有 ui.Image（比如从 rootBundle.instantiateImageCodec 得到的 frame.image），
  /// 可以用这个方法（异步）把它转成 bytes 然后调用上面的方法
  static Future<ImageColorModel?> mostColorFromUiImage(ui.Image image, {int thumbWidth = 40, int thumbHeight = 40}) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;
    return mostColorFromBytes(byteData.buffer.asUint8List(), thumbWidth: thumbWidth, thumbHeight: thumbHeight);
  }

  // RGB -> HSV（r,g,b 输入 0..255）
  static List<double> _rgbToHsv(double r, double g, double b) {
    r /= 255.0;
    g /= 255.0;
    b /= 255.0;

    final double maxVal = max(r, max(g, b));
    final double minVal = min(r, min(g, b));
    double h = 0.0, s = 0.0;
    final double v = maxVal;
    final double delta = maxVal - minVal;

    if (maxVal != 0.0) {
      s = delta / maxVal;
    } else {
      return [-1.0, 0.0, v];
    }

    if (r == maxVal) {
      h = (g - b) / delta;
    } else if (g == maxVal) {
      h = 2.0 + (b - r) / delta;
    } else {
      h = 4.0 + (r - g) / delta;
    }

    h *= 60.0;
    if (h < 0) h += 360.0;

    return [h, s, v];
  }
}

