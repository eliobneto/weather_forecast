import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.hasCancelButton = false,
    this.cancelButton,
    this.confirmButton,
  });

  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool hasCancelButton;
  final TextButton? cancelButton;
  final TextButton? confirmButton;

  Future<void> show(BuildContext context) =>
      showDialog(context: context, builder: build);

  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Constraints.borderRadiusSmall),
      ),
    ),
    title: Text(
      title,
      style:
          titleStyle ??
          context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(
          Constraints.paddingNormal,
          0.0,
          Constraints.paddingNormal,
          Constraints.paddingNormal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: subtitleStyle ?? context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constraints.spacerLarge),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasCancelButton) ...[
                    Expanded(
                      child:
                          cancelButton ??
                          TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(
                              'Cancel',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Palette.primary,
                              ),
                            ),
                          ),
                    ),
                    const SizedBox(width: Constraints.spacerNormal),
                  ],
                  Expanded(
                    child:
                        confirmButton ??
                        TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: Text(
                            'OK',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Palette.primary,
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
