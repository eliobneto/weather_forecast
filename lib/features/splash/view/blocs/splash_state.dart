part of 'splash_cubit.dart';

abstract class SplashState {
  const SplashState();
}

class SplashIdleState extends SplashState {
  const SplashIdleState();
}

class SplashLoadingState extends SplashState {
  const SplashLoadingState();
}

class SplashSuccessState extends SplashState {
  const SplashSuccessState();
}
