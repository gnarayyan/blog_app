import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  // Session? get userSession;

  Future<UserModel> signupUser({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await client.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signupUser(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      final response = await client.auth.signUp(
          password: password, email: email); //data: {'fullName': fullName}

      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
