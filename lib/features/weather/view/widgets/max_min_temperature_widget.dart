import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/widgets/card_widget.dart';
import 'package:weather_forecast/features/weather/domain/models/max_min_temperature_model.dart';

class MaxMinTemperatureWidget extends StatelessWidget {
  const MaxMinTemperatureWidget({
    super.key,
    required this.maxMinTemperatureList,
  });

  final List<MaxMinTemperatureModel> maxMinTemperatureList;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(Constraints.paddingNormal),
    child: CardWidget(
      cardColor: Palette.blue.withValues(alpha: 0.2),
      padding: const EdgeInsets.symmetric(
        horizontal: Constraints.paddingLarger,
        vertical: Constraints.paddingNormal,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Constraints.paddingExtraSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE').format(maxMinTemperatureList[index].time),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Palette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    size: Constraints.iconSizeSmall,
                    color: Palette.red,
                  ),
                  Text(
                    '${maxMinTemperatureList[index].maxTemperature}º',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: Constraints.spacerLarge),
                  const Icon(
                    Icons.arrow_downward,
                    size: Constraints.iconSizeSmall,
                    color: Palette.blue,
                  ),
                  Text(
                    '${maxMinTemperatureList[index].minTemperature}º',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        itemCount: maxMinTemperatureList.length,
      ),
    ),
  );
}
