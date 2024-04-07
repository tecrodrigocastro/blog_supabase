import 'package:auto_injector/auto_injector.dart';
import 'package:blog_supabase/core/env/app_secrets.dart';
import 'package:blog_supabase/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_supabase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final autoInjector = AutoInjector();

Future<void> initDependencies() async {
  initFeatures();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
    debug: true,
  );

  autoInjector.addLazySingleton(() => supabase.client);
}

void initFeatures() {
  final config = BindConfig<Bloc>(
    onDispose: (bloc) => bloc.close(),
    notifier: (bloc) => bloc.stream,
  );
  // Auth
  autoInjector.add<AuthRemoteDataSourcesImpl>(
    (i) => AuthRemoteDataSourcesImpl(
      supabaseClient: i<SupabaseClient>(),
    ),
  );

  autoInjector.add<AuthRepositoryImpl>(
    (i) => AuthRepositoryImpl(
      i<AuthRemoteDataSources>(),
    ),
  );

  autoInjector.add<UserSignUpCase>(
    (i) => UserSignUpCase(
      i<AuthRepositoryImpl>(),
    ),
  );
  autoInjector.addLazySingleton(
    (i) => AuthBloc(
      userSignUpCase: i<UserSignUpCase>(),
    ),
    config: config,
  );
}
