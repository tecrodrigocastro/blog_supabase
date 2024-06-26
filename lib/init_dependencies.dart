import 'package:blog_supabase/core/common/cubit/app_user_cubit.dart';
import 'package:blog_supabase/core/env/app_secrets.dart';
import 'package:blog_supabase/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_supabase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_supabase/features/auth/domain/usecases/current_user.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final autoInjector = GetIt.instance;

Future<void> initDependencies() async {
  initFeatures();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
    debug: true,
  );

  autoInjector.registerLazySingleton(() => supabase.client);

  autoInjector.registerLazySingleton(() => AppUserCubit());
}

void initFeatures() {
  // Auth
  autoInjector.registerFactory<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImpl(
      supabaseClient: autoInjector(),
    ),
  );

  autoInjector.registerFactory<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      autoInjector(),
    ),
  );

  autoInjector.registerFactory<UserSignUpCase>(
    () => UserSignUpCase(
      autoInjector<AuthRepositoryImpl>(),
    ),
  );

  autoInjector.registerFactory<UserLoginCase>(
    () => UserLoginCase(
      autoInjector<AuthRepositoryImpl>(),
    ),
  );

  autoInjector.registerFactory<CurrentUserCase>(
    () => CurrentUserCase(
      autoInjector<AuthRepositoryImpl>(),
    ),
  );

  autoInjector.registerLazySingleton(
    () => AuthBloc(
      userSignUpCase: autoInjector<UserSignUpCase>(),
      userLoginCase: autoInjector<UserLoginCase>(),
      currentUserCase: autoInjector<CurrentUserCase>(),
      appUserCubit: autoInjector<AppUserCubit>(),
    ),
  );
}
