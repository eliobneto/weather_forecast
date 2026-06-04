import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';
import 'package:weather_forecast/features/user/domain/usecases/user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userUsecase}) : super(const UserIdleState());

  final UserUsecase userUsecase;

  Future<void> read() async {
    emit(const UserLoadingState());

    final user = await userUsecase.readLocalUser();

    if (user == null) {
      return emit(
        UserFailState(error: ErrorModel(message: 'Fail to obtain user data.')),
      );
    }

    return emit(UserSuccessState(user: user));
  }
}
