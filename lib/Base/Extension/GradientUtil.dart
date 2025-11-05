import 'dart:ui';
import 'package:flutter/material.dart';

/// 渐变方向定义，对应 Objective-C 中的 ZQGradientChangeDirection
enum GradientDirection {
  level, // 水平渐变
  vertical, // 垂直渐变
  upwardDiagonal, // 主对角线方向渐变
  downwardDiagonal, // 副对角线方向渐变
}

/// Flutter 等价工具类
class GradientUtil {
  /// 生成线性渐变 Shader
  static Shader createGradientShader({
    required Size size,
    required GradientDirection direction,
    required Color startColor,
    required Color endColor,
  }) {
    Alignment begin = Alignment.topLeft;
    Alignment end = Alignment.bottomRight;

    switch (direction) {
      case GradientDirection.level:
        begin = Alignment.centerLeft;
        end = Alignment.centerRight;
        break;
      case GradientDirection.vertical:
        begin = Alignment.topCenter;
        end = Alignment.bottomCenter;
        break;
      case GradientDirection.upwardDiagonal:
        begin = Alignment.bottomLeft;
        end = Alignment.topRight;
        break;
      case GradientDirection.downwardDiagonal:
        begin = Alignment.topLeft;
        end = Alignment.bottomRight;
        break;
    }

    return LinearGradient(
      begin: begin,
      end: end,
      colors: [startColor, endColor],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  /// 生成一个可直接用作装饰背景的 BoxDecoration
  static BoxDecoration createGradientBox({
    required GradientDirection direction,
    required Color startColor,
    required Color endColor,
  }) {
    Alignment begin = Alignment.topLeft;
    Alignment end = Alignment.bottomRight;

    switch (direction) {
      case GradientDirection.level:
        begin = Alignment.centerLeft;
        end = Alignment.centerRight;
        break;
      case GradientDirection.vertical:
        begin = Alignment.topCenter;
        end = Alignment.bottomCenter;
        break;
      case GradientDirection.upwardDiagonal:
        begin = Alignment.bottomLeft;
        end = Alignment.topRight;
        break;
      case GradientDirection.downwardDiagonal:
        begin = Alignment.topLeft;
        end = Alignment.bottomRight;
        break;
    }

    return BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: [startColor, endColor],
      ),
    );
  }
}
