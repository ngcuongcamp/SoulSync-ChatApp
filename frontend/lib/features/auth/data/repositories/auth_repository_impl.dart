/**
  - **auth_repository_impl.dart**: 
    + nó thực hiện các phương thức được định nghĩa trong interface **auth_repository.dart** của tầng `domain`
    + nó kết nối tầng `domain` và `data`, giúp `domain layer` không phụ thuộc vào các dữ liệu được lấy từ (API, database,...)
    + gọi `datasource` để lấy dữ liệu, xử lý nếu cần rồi trả về tầng `domain`
    + `đóng vai trò trung gian`, giúp việc thay đổi nguồn dữ liệu (`API mới, database mới`) mà không ảnh hưởng đến `domain layer`
 */

import 'package:soul_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:soul_app/features/auth/domain/entities/user_entity.dart';
import 'package:soul_app/features/auth/domain/repositories/auth_respository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register(
      String username, String email, String password) async {
    return await authRemoteDataSource.register(
        username: username, email: email, password: password);
  }
}
