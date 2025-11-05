import 'package:flutter/material.dart';

class AZGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final AlignmentGeometry startPoint;
  final AlignmentGeometry endPoint;

  const AZGradientText(
      this.text, {
        Key? key,
        required this.colors,
        this.style,
        this.startPoint = Alignment.centerLeft,
        this.endPoint = Alignment.centerRight,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: startPoint,
        end: endPoint,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
      ),
    );
  }
}
