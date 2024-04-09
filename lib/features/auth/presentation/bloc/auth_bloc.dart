import 'package:blog_supabase/core/common/cubit/app_user_cubit.dart';
import 'package:blog_supabase/core/common/entities/user_entity.dart';
import 'package:blog_supabase/core/usecases/usecase.dart';
import 'package:blog_supabase/features/auth/domain/usecases/current_user.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;
  final UserLoginCase _userLoginCase;
  final CurrentUserCase _currentUserCase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUpCase userSignUpCase,
    required UserLoginCase userLoginCase,
    required CurrentUserCase currentUserCase,
    required AppUserCubit appUserCubit,
  })  : _userSignUpCase = userSignUpCase,
        _userLoginCase = userLoginCase,
        _currentUserCase = currentUserCase,
        _appUserCubit = appUserCubit,
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
            value.fold((failure) => emit(AuthError(failure.message)),
                (user) => _emitAuthSucess(user, emit));
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
            value.fold((failure) => emit(AuthError(failure.message)),
                (user) => _emitAuthSucess(user, emit));
          },
        );
      },
    );

    on<AuthIsUserLoggedIn>(
      (event, emit) async {
        emit(AuthLoading());
        await _currentUserCase.call(NoParams()).then(
          (value) {
            value.fold(
              (failure) => emit(AuthError(failure.message)),
              (user) => _emitAuthSucess(user, emit),
            );
          },
        );
      },
    );
  }

  void _emitAuthSucess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
