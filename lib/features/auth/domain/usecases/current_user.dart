import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/core/usecases/usecase.dart';
import 'package:blog_supabase/features/auth/domain/entities/user_entity.dart';
import 'package:blog_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  CurrentUserCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
