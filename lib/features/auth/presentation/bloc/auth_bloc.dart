import 'package:bloc/bloc.dart';
import 'package:blog_supabase/features/auth/domain/entities/user_entity.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;
  AuthBloc({required UserSignUpCase userSignUpCase})
      : _userSignUpCase = userSignUpCase,
        super(AuthInitial()) {
    on<SignUpWithEmailAndPassword>(
      (event, emit) async {
        await _userSignUpCase
            .call(UserSignUpCaseParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ))
            .then(
          (value) {
            value.fold(
              (failure) => emit(AuthError(failure.message)),
              (user) => emit(AuthSuccess(user)),
            );
          },
        );
      },
    );
  }
}
