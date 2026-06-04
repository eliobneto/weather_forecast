import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_forecast/core/api/get_it.dart';
import 'package:weather_forecast/core/definitions/paths.dart';
import 'package:weather_forecast/core/definitions/theme.dart';
import 'package:weather_forecast/features/auth/view/screens/login_screen.dart';
import 'package:weather_forecast/features/splash/view/screens/splash_screen.dart';
import 'package:weather_forecast/features/weather/view/screens/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(Paths.loginBackground), context);
    precacheImage(const AssetImage(Paths.weatherBackground), context);

    return MaterialApp(
      theme: AppTheme.instance.theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/weather': (context) => const WeatherScreen(),
      },
    );
  }
}
