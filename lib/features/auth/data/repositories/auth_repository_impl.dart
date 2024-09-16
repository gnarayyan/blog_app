import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  }) async =>
      _proceedAuth(
        () async => remoteDataSource.loginUser(
          email: email,
          password: password,
        ),
      );

  @override
  Future<Either<Failure, UserEntity>> signupUser({
    required String fullName,
    required String email,
    required String password,
  }) async =>
      _proceedAuth(
        () async => remoteDataSource.signupUser(
          fullName: fullName,
          email: email,
          password: password,
        ),
      );

// Refactoring
  Future<Either<Failure, UserEntity>> _proceedAuth(
      Future<UserEntity> Function() callback) async {
    try {
      final user = await callback();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
