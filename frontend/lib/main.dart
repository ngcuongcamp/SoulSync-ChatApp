import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:soul_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:soul_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:soul_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:soul_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soul_app/features/auth/presentation/pages/login_page.dart';
import 'package:soul_app/features/auth/presentation/pages/register_page.dart';
import 'package:soul_app/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:soul_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:soul_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:soul_app/features/conversation/presentation/pages/conversations_page.dart';
import 'package:soul_app/pages/chat_page.dart';
import 'package:soul_app/features/conversation/data/datasources/conversations_remote_data_source.dart';

void main() {
  final authRepository =
      AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());

  final conversationsRepository = ConversationsRepositoryImpl(
      conversationsRemoteDataSource: ConversationsRemoteDataSource());

  runApp(MyApp(
    authRepository: authRepository,
    conversationsRepository: conversationsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.conversationsRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
            fetchConversationsUseCase:
                FetchConversationsUseCase(repository: conversationsRepository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'SoulSync - Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: RegisterPage(),
        routes: {
          "/login": (_) => LoginPage(),
          "/register": (_) => RegisterPage(),
          "/chat": (_) => ChatPage(),
          "/home": (_) => ConversationsPage(),
        },
      ),
    );
  }
}
