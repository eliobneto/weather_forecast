import 'package:weather_forecast/features/user/domain/abstractions/iuser_repository.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

class UserUsecase {
  UserUsecase({required this.userRepository});

  final IUserRepository userRepository;

  Future<UserModel?> readLocalUser() => userRepository.readLocalUser();

  Future<void> writeLocalUser(UserModel user) =>
      userRepository.writeLocalUser(user);

  Future<void> clearLocalUser() => userRepository.clearLocalUser();
}
