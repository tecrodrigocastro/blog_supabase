import 'package:blog_supabase/core/theme/theme.dart';
import 'package:blog_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_supabase/features/auth/presentation/pages/login_page.dart';
import 'package:blog_supabase/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => autoInjector<AuthBloc>(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
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
