import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginParams {
  final String email;
  final String password;

  const UserLoginParams({required this.email, required this.password});
}

class UserLogin implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return await authRepository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}
