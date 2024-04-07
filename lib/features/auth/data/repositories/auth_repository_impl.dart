import 'package:blog_supabase/core/error/exception.dart';
import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources authDataSource;

  const AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(userId);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
