import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '/core/theme/app_pallete.dart';
import './signup_page.dart';
import '../widgets/auth_info.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) showSnackbar(context, state.message);
            },
            builder: (context, state) {
              if (state is AuthLoading) return const Loader();
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 36),
                    ),
                    const SizedBox(height: 30),
                    AuthField(hintText: 'Email', controller: emailController),
                    const SizedBox(height: 10),
                    AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        isObscureText: true),
                    const SizedBox(height: 25),
                    AuthGradientButton(
                        label: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        }),
                    const SizedBox(height: 10),
                    const AuthInfo(
                      text1: "Don't have an account?  ",
                      text2: "Signup",
                      route: SignupPage.route,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
