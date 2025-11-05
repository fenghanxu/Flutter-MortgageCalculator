import 'package:flutter/material.dart';

/// 渐变文字或控件封装类（等效于 GradualChange）
class GradualChange {
  /// 对应 Objective-C 中的
  /// +(void)TextGradientview:bgVIew:gradientColors:gradientStartPoint:endPoint:
  static Widget textGradientView({
    required Widget child,
    required List<Color> colors,
    AlignmentGeometry startPoint = Alignment.centerLeft,
    AlignmentGeometry endPoint = Alignment.centerRight,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: colors,
          begin: startPoint,
          end: endPoint,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn, // 保留文字本身的透明度，只让颜色被渐变替换
      child: child,
    );
  }

  /// 对应 Objective-C 中的
  /// +(void)TextGradientControl:bgVIew:gradientColors:gradientStartPoint:endPoint:
  static Widget textGradientControl({
    required Widget child,
    required List<Color> colors,
    AlignmentGeometry startPoint = Alignment.centerLeft,
    AlignmentGeometry endPoint = Alignment.centerRight,
  }) {
    // 控件其实和文字处理方式一致，只是 child 可以是任意按钮类控件
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: colors,
          begin: startPoint,
          end: endPoint,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}
