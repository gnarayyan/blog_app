import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signupUser({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  });
}
