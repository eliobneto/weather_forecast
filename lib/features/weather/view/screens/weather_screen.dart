import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/get_it.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/definitions/paths.dart';
import 'package:weather_forecast/core/widgets/appbar_widget.dart';
import 'package:weather_forecast/core/widgets/circular_loading_widget.dart';
import 'package:weather_forecast/core/widgets/dialog_widget.dart';
import 'package:weather_forecast/core/widgets/no_glow_widget.dart';
import 'package:weather_forecast/core/widgets/retry_widget.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_cubit/auth_cubit.dart';
import 'package:weather_forecast/features/weather/view/blocs/geolocation_cubit/geolocation_cubit.dart';
import 'package:weather_forecast/features/weather/view/blocs/weather_cubit/weather_cubit.dart';
import 'package:weather_forecast/features/weather/view/widgets/current_weather_widget.dart';
import 'package:weather_forecast/features/weather/view/widgets/hourly_temperature_widget.dart';
import 'package:weather_forecast/features/weather/view/widgets/max_min_temperature_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final AuthCubit authCubit;
  late final GeolocationCubit geolocationCubit;
  late final WeatherCubit weatherCubit;

  @override
  void initState() {
    super.initState();

    authCubit = getIt<AuthCubit>();
    geolocationCubit = getIt<GeolocationCubit>()..getCurrentPosition();
    weatherCubit = getIt<WeatherCubit>();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Paths.weatherBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Palette.transparent,
        appBar: AppBarWidget(
          hasLeading: false,
          title: 'Weather forecast',
          backgroundColor: Palette.primary.withValues(alpha: 0.5),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Palette.white,
                size: Constraints.iconSizeNormal,
              ),
              onPressed: () => DialogWidget(
                title: 'Logout',
                subtitle: 'You\'ll be returning to login page.',
                hasCancelButton: true,
                confirmButton: TextButton(
                  onPressed: authCubit.logout,
                  child: Text(
                    'OK',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Palette.primary,
                    ),
                  ),
                ),
              ).show(context),
            ),
          ],
        ),
        body: BlocConsumer<GeolocationCubit, GeolocationState>(
          bloc: geolocationCubit,
          listener: (context, state) {
            if (state is GeolocationSuccessState) {
              weatherCubit.getCurrentWeather(state.location);
            }
          },
          builder: (context, geolocationState) {
            if (geolocationState is GeolocationFailState) {
              return Center(
                child: RetryWidget(
                  message: geolocationState.error.message,
                  onRetry: geolocationCubit.getCurrentPosition,
                ),
              );
            }

            return BlocBuilder<WeatherCubit, WeatherState>(
              bloc: weatherCubit,
              builder: (context, state) {
                if (state is WeatherFailState) {
                  return Center(
                    child: RetryWidget(
                      message: state.error.message,
                      onRetry: () => weatherCubit.getCurrentWeather(
                        (geolocationState as GeolocationSuccessState).location,
                      ),
                    ),
                  );
                }

                if (geolocationState is GeolocationSuccessState &&
                    state is WeatherSuccessState) {
                  return RefreshIndicator(
                    color: Palette.primary,
                    onRefresh: () => weatherCubit.getCurrentWeather(
                      geolocationState.location,
                    ),
                    child: NoGlowWidget(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            CurrentWeatherWidget(
                              currentWeather: state.weather.currentWeather,
                              currentMaxMinTemperature:
                                  state.weather.currentMaxMinTemperature,
                            ),
                            HourlyTemperatureWidget(
                              hourlyTemperatureList:
                                  state.weather.hourlyTemperatureList,
                            ),
                            MaxMinTemperatureWidget(
                              maxMinTemperatureList:
                                  state.weather.maxMinTemperatureList,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return const CircularLoadingWidget();
              },
            );
          },
        ),
      ),
    ],
  );
}
