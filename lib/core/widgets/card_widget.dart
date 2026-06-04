import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/palette.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Constraints.paddingNormal,
      vertical: Constraints.paddingLarger,
    ),
    this.constraints,
    this.cardColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.border,
    this.elevation = 0.0,
    this.child,
  });

  final EdgeInsets padding;
  final BoxConstraints? constraints;
  final Color? cardColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry? border;
  final double elevation;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Material(
    color: Palette.transparent,
    elevation: elevation,
    borderRadius:
        border ??
        const BorderRadius.all(Radius.circular(Constraints.borderRadiusSmall)),
    child: Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: cardColor ?? Palette.white,
        border: Border.all(
          color: borderColor ?? Palette.transparent,
          width: borderWidth,
        ),
        borderRadius:
            border ??
            const BorderRadius.all(
              Radius.circular(Constraints.borderRadiusSmall),
            ),
      ),
      child: child ?? const SizedBox.shrink(),
    ),
  );
}
