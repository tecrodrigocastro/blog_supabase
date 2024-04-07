import 'package:blog_supabase/core/theme/app_pallete.dart';
import 'package:blog_supabase/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_supabase/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_supabase/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
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
              AuthGradientButton(text: 'Sign In', onPressed: () {}),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
        ),
      ),
    );
  }
}
