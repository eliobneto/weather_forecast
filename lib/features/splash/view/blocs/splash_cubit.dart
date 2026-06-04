import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashIdleState());

  Future<void> init() async {
    emit(const SplashLoadingState());

    ErrorWidget.builder = (_) => const SizedBox.shrink();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );

    await Future.delayed(const Duration(seconds: 1));

    return emit(const SplashSuccessState());
  }
}
