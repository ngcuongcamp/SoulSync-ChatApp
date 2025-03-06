/*
   domain/repositories/auth_respository.dart
*/

import 'package:soul_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // lớp trừu tượng, không xử lý logic
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String username, String email, String password);
}
