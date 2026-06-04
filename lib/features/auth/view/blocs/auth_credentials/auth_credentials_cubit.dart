import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';
import 'package:weather_forecast/features/auth/domain/usecases/auth_usecase.dart';

part 'auth_credentials_state.dart';

class AuthCredentialsCubit extends Cubit<AuthCredentialsState> {
  AuthCredentialsCubit({required this.authUsecase})
    : super(const AuthCredentialsIdleState());

  final AuthUsecase authUsecase;

  Future<void> getCredentials() async {
    emit(const AuthCredentialsLoadingState());

    final credentials = await authUsecase.readLocalCredentials();

    return emit(AuthCredentialsSuccessState(credentials: credentials));
  }
}
