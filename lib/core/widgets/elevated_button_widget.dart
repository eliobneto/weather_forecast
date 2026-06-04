import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/widgets/circular_loading_widget.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.buttonColor,
    this.labelColor,
    required this.label,
  });

  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;
  final Color? buttonColor;
  final Color? labelColor;
  final String label;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: enabled ? onPressed : null,
    style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
    child: isLoading
        ? SizedBox.square(
            dimension: Constraints.iconSizeNormal,
            child: CircularLoadingWidget(color: labelColor ?? Palette.white),
          )
        : Text(label, style: TextStyle(color: labelColor ?? Palette.white)),
  );
}
