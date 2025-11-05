import 'package:flutter/material.dart';

class AZGradientView extends StatelessWidget {
  final List<Color> colors;
  final List<double>? locations;
  final AlignmentGeometry startPoint;
  final AlignmentGeometry endPoint;
  final Widget? child;

  const AZGradientView({
    Key? key,
    required this.colors,
    this.locations,
    this.startPoint = Alignment.centerLeft,
    this.endPoint = Alignment.centerRight,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: locations,
          begin: startPoint,
          end: endPoint,
        ),
      ),
      child: child,
    );
  }
}
