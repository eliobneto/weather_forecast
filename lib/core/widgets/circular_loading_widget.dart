import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({
    super.key,
    this.color = Palette.primary,
    this.size = 4.0,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(color: color, strokeWidth: size),
  );
}
