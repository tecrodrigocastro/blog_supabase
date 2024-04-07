import 'package:blog_supabase/core/env/app_secrets.dart';
import 'package:blog_supabase/core/theme/theme.dart';
import 'package:blog_supabase/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_supabase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_supabase/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_supabase/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
    debug: true,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUpCase: UserSignUpCase(
            AuthRepositoryImpl(
              AuthRemoteDataSourcesImpl(
                supabaseClient: supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const AppWidget(),
  ));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Supabase',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
