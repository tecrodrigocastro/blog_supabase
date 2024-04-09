import 'package:blog_supabase/core/common/widgets/loading.dart';
import 'package:blog_supabase/core/theme/app_pallete.dart';
import 'package:blog_supabase/core/utils/show_snackbar.dart';
import 'package:blog_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_supabase/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_supabase/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_supabase/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_supabase/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showMessageSnackBar(context, state.message, color: Colors.red);
            }
            if (state is AuthSuccess) {
              showMessageSnackBar(context, 'Bem vindo, ${state.user.name}');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const BlogPage();
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loading();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: 'Email', controller: emailEC),
                  const SizedBox(height: 15),
                  AuthField(
                      hintText: 'Password',
                      controller: passwordEC,
                      obscureText: true),
                  const SizedBox(height: 15),
                  AuthGradientButton(
                      text: 'Sign In',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authBloc.add(LoginWithEmailAndPassword(
                            email: emailEC.text.trim(),
                            password: passwordEC.text.trim(),
                          ));
                        }
                      }),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
