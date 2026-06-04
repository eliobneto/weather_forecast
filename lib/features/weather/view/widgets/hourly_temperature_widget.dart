import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/widgets/card_widget.dart';
import 'package:weather_forecast/features/weather/domain/models/hourly_temperature_model.dart';

class HourlyTemperatureWidget extends StatefulWidget {
  const HourlyTemperatureWidget({
    super.key,
    required this.hourlyTemperatureList,
  });

  final List<HourlyTemperatureModel> hourlyTemperatureList;

  @override
  State<HourlyTemperatureWidget> createState() =>
      _HourlyTemperatureWidgetState();
}

class _HourlyTemperatureWidgetState extends State<HourlyTemperatureWidget> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(Constraints.paddingNormal),
    child: CardWidget(
      padding: const EdgeInsets.all(Constraints.paddingNormal),
      cardColor: Palette.blue.withValues(alpha: 0.2),
      child: SizedBox(
        height: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.hourlyTemperatureList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constraints.paddingSmall,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat(
                    'HH:mm',
                  ).format(widget.hourlyTemperatureList[index].time),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: Palette.white,
                  ),
                ),
                const SizedBox(height: Constraints.spacerSmall),
                Text(
                  '${widget.hourlyTemperatureList[index].temperature}º',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Palette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
