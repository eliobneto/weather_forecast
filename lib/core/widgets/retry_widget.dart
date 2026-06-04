import 'package:flutter/material.dart';
import 'package:weather_forecast/core/api/get_it.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_cubit/auth_cubit.dart';

class RetryWidget extends StatefulWidget {
  const RetryWidget({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  State<RetryWidget> createState() => _RetryWidgetState();
}

class _RetryWidgetState extends State<RetryWidget> {
  late final AuthCubit authCubit;

  @override
  void initState() {
    super.initState();

    authCubit = getIt<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Constraints.paddingLarge),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.message,
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Constraints.spacerNormal),
        TextButton.icon(
          onPressed: widget.onRetry,
          icon: const Icon(Icons.refresh, color: Palette.primary),
          label: Text(
            'Try again',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Palette.primary,
            ),
          ),
        ),
      ],
    ),
  );
}
