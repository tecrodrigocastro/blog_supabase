import 'package:blog_supabase/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSources {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourcesImpl({required this.supabaseClient});

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }
}
