import 'package:soul_app/features.auth/domain/repositories/auth_respository.dart';
import 'package:soul_app/features.auth/domain/entities/user_entity.dart';

class RegisterUseCase {
  // gọi đến AuthRepository để thực hiện logic đăng ký
  final AuthRespository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}
