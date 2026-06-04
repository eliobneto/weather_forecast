import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/features/weather/domain/models/max_min_temperature_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.currentWeather,
    required this.currentMaxMinTemperature,
  });

  final int currentWeather;
  final MaxMinTemperatureModel currentMaxMinTemperature;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(Constraints.paddingNormal),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$currentWeatherº',
          style: context.textTheme.headlineMedium!.copyWith(
            fontSize: 100.0,
            color: Palette.white,
          ),
        ),
        const SizedBox(width: Constraints.spacerNormal),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_upward,
              size: Constraints.iconSizeExtraLarge,
              color: Palette.red,
            ),
            Text(
              '${currentMaxMinTemperature.maxTemperature}º',
              style: context.textTheme.displayMedium!.copyWith(
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: Constraints.spacerLarge),
            const Icon(
              Icons.arrow_downward,
              size: Constraints.iconSizeExtraLarge,
              color: Palette.blue,
            ),
            Text(
              '${currentMaxMinTemperature.minTemperature}º',
              style: context.textTheme.displayMedium!.copyWith(
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
