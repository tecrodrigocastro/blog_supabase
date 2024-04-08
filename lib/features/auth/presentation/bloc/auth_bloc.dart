import 'package:bloc/bloc.dart';
import 'package:blog_supabase/features/auth/domain/entities/user_entity.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;
  final UserLoginCase _userLoginCase;
  AuthBloc(
      {required UserSignUpCase userSignUpCase,
      required UserLoginCase userLoginCase})
      : _userSignUpCase = userSignUpCase,
        _userLoginCase = userLoginCase,
        super(AuthInitial()) {
    on<SignUpWithEmailAndPassword>(
      (event, emit) async {
        emit(AuthLoading());
        await _userSignUpCase
            .call(
          UserSignUpCaseParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        )
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

    on<LoginWithEmailAndPassword>(
      (event, emit) async {
        emit(AuthLoading());
        await _userLoginCase
            .call(
          UserLoginCaseParams(
            email: event.email,
            password: event.password,
          ),
        )
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
