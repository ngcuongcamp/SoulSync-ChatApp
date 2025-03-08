// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:soul_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:soul_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:soul_app/features/auth/presentation/widgets/auth_input_field.dart';

import 'package:soul_app/features/auth/presentation/widgets/register_prompt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
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
                "Register",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Chat Anytime, Anywhere",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontStyle: FontStyle.italic, letterSpacing: 0.7),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              AuthInputField(
                  hint: 'Username',
                  icon: Icons.person,
                  controller: _usernameController,
                  isPassword: false),
              SizedBox(height: 20),
              AuthInputField(
                  hint: 'Email',
                  icon: Icons.email,
                  controller: _emailController,
                  isPassword: false),
              SizedBox(height: 20),
              AuthInputField(
                  hint: 'Password',
                  icon: Icons.password,
                  controller: _passwordController,
                  isPassword: true),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return AuthButton(
                  text: 'Register',
                  onPressed: _onRegister,
                );
              }, listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushNamed(context, '/login');
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              }),
              SizedBox(height: 20),
              RegisterPrompt(
                title: "Already have an account. ",
                subtitle: "Click here to login",
                // onRegister: _onRegister,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onRegister() {
    // const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    // Random random = Random();
    // String firstChar = chars[random.nextInt(chars.length)];
    // String secondChar = chars[random.nextInt(chars.length)];

    // _usernameController.text = "_ngcuongzth_$firstChar$secondChar";
    // _emailController.text = "nguyencuongzth@gmail.com$firstChar$secondChar";
    _passwordController.text = "jnc";

    String usernameValue = _usernameController.text.trim();
    String emailValue = _emailController.value.text.trim();
    String passwordValue = _passwordController.text.trim();

    if (usernameValue.isEmpty || emailValue.isEmpty || passwordValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // gửi sự kiện Register đến AuthBloc
    // sau khi sự kiện RegisterEvent được gọi thì `Bloc` sẽ gọi _onRegister() để xử lý
    BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
      username: usernameValue,
      email: emailValue,
      password: passwordValue,
    ));
  }
}
