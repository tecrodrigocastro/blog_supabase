import 'package:blog_supabase/core/error/exception.dart';
import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_supabase/features/auth/domain/entities/user_entity.dart';
import 'package:blog_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources authDataSource;

  const AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await authDataSource.getCurrentUser();
      if (user == null) {
        return Left(Failure('No user is signed in'));
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
