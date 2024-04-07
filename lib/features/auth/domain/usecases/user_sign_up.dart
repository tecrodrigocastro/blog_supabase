import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/core/usecases/usecase.dart';
import 'package:blog_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUpCase implements UseCase<String, UserSignUpCaseParams> {
  final AuthRepository repository;

  UserSignUpCase(this.repository);
  @override
  Future<Either<Failure, String>> call(UserSignUpCaseParams params) async {
    return await repository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpCaseParams {
  final String name;
  final String email;
  final String password;

  UserSignUpCaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
