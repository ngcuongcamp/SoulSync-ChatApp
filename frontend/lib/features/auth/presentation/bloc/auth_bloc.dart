/**
       presentation/bloc/auth_bloc.dart
 */

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:soul_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // AuthBloc nhận vào AuthEvent và trả về AuthState
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase})
      : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    // lắng nghe sự kiện đăng ký và đăng nhập
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    // event: chứa thông tin đăng ký
    // emit : dùng để phát ra các trạng thái (AuthState)

    emit(AuthLoading());
    try {
      // registerUseCase xử lý logic đăng ký trong UseCase
      // final user =
      //     await registerUseCase(event.username, event.email, event.password);

      await registerUseCase(event.username, event.email, event.password);
      emit(AuthSuccess(message: "Registration successful"));
    } catch (error) {
      emit(AuthFailure(error: "Registration failed"));
      log('AUTH_BLOC REGISTER ERROR: $error');
      // print('AUTH_BLOC REGISTER ERROR: $error');
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      await _storage.write(key: "token", value: user.token);

      emit(AuthSuccess(message: "Login successful"));
    } catch (error) {
      emit(AuthFailure(error: "Login failed"));
      log('AUTH_BLOC LOGIN ERROR: $error');
    }
  }
}
