import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_app/features.auth/presentation/bloc/auth_bloc.dart';
import 'package:soul_app/features.auth/presentation/bloc/auth_event.dart';
import 'package:soul_app/features.auth/presentation/bloc/auth_state.dart';
import 'package:soul_app/features.auth/presentation/widgets/auth_button.dart';

import 'package:soul_app/features.auth/presentation/widgets/auth_input_field.dart';
import 'package:soul_app/features.auth/presentation/widgets/login_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Your Conversations Await – Sign In Now!",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontStyle: FontStyle.italic, letterSpacing: 0.7),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              AuthInputField(
                hint: 'Email',
                icon: Icons.email,
                controller: _emailController,
              ),
              SizedBox(height: 20),
              AuthInputField(
                hint: 'Password',
                icon: Icons.password,
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return AuthButton(
                  text: 'Login',
                  onPressed: _onLoginTapped,
                );
              }, listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushNamed(context, '/login');
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              }),
              // AuthButton(text: 'Login', onPressed: _onLoginTapped),
              SizedBox(height: 20),
              LoginPrompt(
                title: "Don't have an account? ",
                subtitle: "Sign up here",
                onLogin: _onLoginTapped,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginTapped() {
    String emailValue = _emailController.value.text.trim();
    String passwordValue = _passwordController.value.text.trim();

    if (emailValue.isEmpty || passwordValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // gửi sự kiện Register đến AuthBloc
    // sau khi sự kiện RegisterEvent được gọi thì `Bloc` sẽ gọi _onRegister() để xử lý
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
      email: emailValue,
      password: passwordValue,
    ));
  }
}
