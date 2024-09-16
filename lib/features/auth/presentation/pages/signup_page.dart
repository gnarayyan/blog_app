import 'dart:io';

import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/image_picker_button.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  File? profilePicture;

  final formKey = GlobalKey<FormState>();

  void setProfilePicture(File? image) => profilePicture = image;

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
                      'Signup',
                      style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 36),
                    ),
                    const SizedBox(height: 30),
                    AuthField(hintText: 'Fullname', controller: nameController),
                    const SizedBox(height: 10),
                    AuthField(hintText: 'Email', controller: emailController),
                    const SizedBox(height: 10),
                    AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        isObscureText: true),
                    ImagePickerButton(
                      labelText: 'Profile Picture',
                      setImage: setProfilePicture,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 25),
                    AuthGradientButton(
                        label: 'Signup',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSingup(
                                    email: emailController.text.trim(),
                                    fullName: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        }),
                    const SizedBox(height: 10),
                    const AuthInfo(
                        text1: "Already have an account?  ",
                        text2: "Login",
                        route: LoginPage.route)
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
