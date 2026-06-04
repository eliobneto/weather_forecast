import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/get_it.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/definitions/paths.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_cubit/auth_cubit.dart';
import 'package:weather_forecast/features/splash/view/blocs/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthCubit authCubit;
  late final SplashCubit splashCubit;

  @override
  void initState() {
    super.initState();

    authCubit = getIt<AuthCubit>();
    splashCubit = getIt<SplashCubit>()..init();
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<SplashCubit, SplashState>(
        bloc: splashCubit,
        listenWhen: (_, current) => current is SplashSuccessState,
        listener: (context, state) => authCubit.reauth(),
      ),
      BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.of(context).pushNamed('/weather');
          } else if (state is UnauthenticatedState) {
            Navigator.of(context).pushNamed('/login');
          }
        },
      ),
    ],
    child: SafeArea(
      child: Scaffold(
        backgroundColor: Palette.black,
        body: Center(
          child: ClipOval(
            child: Image.asset(Paths.logo, width: 160.0, height: 160.0),
          ),
        ),
      ),
    ),
  );
}
