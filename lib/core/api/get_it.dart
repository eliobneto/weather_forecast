import 'package:get_it/get_it.dart';
import 'package:weather_forecast/core/api/dio_api.dart';
import 'package:weather_forecast/core/api/secure_local_storage.dart';
import 'package:weather_forecast/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:weather_forecast/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:weather_forecast/features/auth/data/repositories/auth_repository.dart';
import 'package:weather_forecast/features/auth/domain/abstractions/iauth_repository.dart';
import 'package:weather_forecast/features/auth/domain/interceptors/auth_interceptor.dart';
import 'package:weather_forecast/features/auth/domain/usecases/auth_usecase.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_credentials/auth_credentials_cubit.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_cubit/auth_cubit.dart';
import 'package:weather_forecast/features/splash/view/blocs/splash_cubit.dart';
import 'package:weather_forecast/features/user/data/datasources/user_local_datasource.dart';
import 'package:weather_forecast/features/user/data/repositories/user_repository.dart';
import 'package:weather_forecast/features/user/domain/abstractions/iuser_repository.dart';
import 'package:weather_forecast/features/user/domain/usecases/user_usecase.dart';
import 'package:weather_forecast/features/user/view/blocs/user_cubit.dart';
import 'package:weather_forecast/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_forecast/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_forecast/features/weather/domain/abstractions/iweather_repository.dart';
import 'package:weather_forecast/features/weather/domain/usecases/geolocation_usecase.dart';
import 'package:weather_forecast/features/weather/domain/usecases/weather_usecase.dart';
import 'package:weather_forecast/features/weather/view/blocs/geolocation_cubit/geolocation_cubit.dart';
import 'package:weather_forecast/features/weather/view/blocs/weather_cubit/weather_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<IDioApi>(DioApi.new);
  getIt.registerLazySingleton<ISecureLocalStorage>(SecureLocalStorage.new);

  // LOCAL DATASOURCES
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(storage: getIt<ISecureLocalStorage>()),
  );
  getIt.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasource(storage: getIt<ISecureLocalStorage>()),
  );

  // REMOTE DATASOURCES
  getIt.registerLazySingleton<AuthRemoteDatasource>(AuthRemoteDatasource.new);
  getIt.registerLazySingleton<WeatherRemoteDatasource>(
    () => WeatherRemoteDatasource(api: getIt<IDioApi>()),
  );

  // REPOSITORIES
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      remoteDatasource: getIt<AuthRemoteDatasource>(),
      localDatasource: getIt<AuthLocalDatasource>(),
    ),
  );
  getIt.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepository(remoteDatasource: getIt<WeatherRemoteDatasource>()),
  );
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepository(localDatasource: getIt<UserLocalDatasource>()),
  );

  // INTERCEPTORS
  getIt.registerLazySingleton<IAuthInterceptor>(
    () => AuthInterceptor(
      authRepository: getIt<IAuthRepository>(),
      userRepository: getIt<IUserRepository>(),
    ),
  );

  // USECASES
  getIt.registerLazySingleton<AuthUsecase>(
    () => AuthUsecase(authRepository: getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<GeolocationUsecase>(GeolocationUsecase.new);
  getIt.registerLazySingleton<UserUsecase>(
    () => UserUsecase(userRepository: getIt<IUserRepository>()),
  );
  getIt.registerLazySingleton<WeatherUsecase>(
    () => WeatherUsecase(weatherRepository: getIt<IWeatherRepository>()),
  );

  // CUBITS
  getIt.registerLazySingleton<AuthCredentialsCubit>(
    () => AuthCredentialsCubit(authUsecase: getIt<AuthUsecase>()),
  );
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      authUsecase: getIt<AuthUsecase>(),
      userUsecase: getIt<UserUsecase>(),
    ),
  );
  getIt.registerLazySingleton<GeolocationCubit>(
    () => GeolocationCubit(geolocationUsecase: getIt<GeolocationUsecase>()),
  );
  getIt.registerLazySingleton<SplashCubit>(SplashCubit.new);
  getIt.registerLazySingleton<UserCubit>(
    () => UserCubit(userUsecase: getIt<UserUsecase>()),
  );
  getIt.registerLazySingleton<WeatherCubit>(
    () => WeatherCubit(weatherUsecase: getIt<WeatherUsecase>()),
  );

  final dioApi = getIt<IDioApi>() as DioApi;

  dioApi.addInterceptors(authInterceptor: getIt<IAuthInterceptor>());
}
