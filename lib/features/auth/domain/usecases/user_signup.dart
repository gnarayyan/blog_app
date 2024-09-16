import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignupParams {
  final String fullName;
  final String email;

  final String password;

  UserSignupParams(
      {required this.fullName, required this.email, required this.password});
}

class UserSignup implements UseCase<UserEntity, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignup({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserSignupParams params) async {
    return await authRepository.signupUser(
        fullName: params.fullName,
        email: params.email,
        password: params.password);
  }
}
