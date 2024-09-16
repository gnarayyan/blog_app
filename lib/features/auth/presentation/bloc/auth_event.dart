part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSingup extends AuthEvent {
  final String email;
  final String fullName;
  final String password;

  const AuthSingup(
      {required this.email, required this.fullName, required this.password});
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});
}
