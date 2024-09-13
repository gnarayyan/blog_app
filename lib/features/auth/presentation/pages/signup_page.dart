import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_info.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
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
                const SizedBox(height: 25),
                const AuthGradientButton(label: 'Signup'),
                const SizedBox(height: 10),
                const AuthInfo(
                    text1: "Already have an account?  ",
                    text2: "Login",
                    route: LoginPage.route)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
