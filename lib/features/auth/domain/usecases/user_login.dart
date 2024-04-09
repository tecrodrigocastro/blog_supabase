// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_supabase/core/common/entities/user_entity.dart';
import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/core/usecases/usecase.dart';
import 'package:blog_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginCase implements UseCase<UserEntity, UserLoginCaseParams> {
  final AuthRepository authRepository;
  UserLoginCase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(UserLoginCaseParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginCaseParams {
  final String email;
  final String password;

  UserLoginCaseParams({
    required this.email,
    required this.password,
  });
}
