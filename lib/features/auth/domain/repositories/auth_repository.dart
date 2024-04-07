import 'package:blog_supabase/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

/// `AuthRepository` é uma classe abstrata que define a interface para um repositório de autenticação.
abstract interface class AuthRepository {
  /// Método `signUpWithEmailAndPassword` é usado para registrar um novo usuário com um email e senha.
  /// Ele recebe três parâmetros: `name`, `email` e `password`, todos obrigatórios (`required`).
  /// O método retorna um `Future<Either<Failure, String>>`. Isso significa que é uma operação assíncrona
  /// que, quando concluída, pode resultar em um `Failure` (se ocorrer um erro) ou em uma `String`
  /// (se a operação for bem-sucedida).
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  /// Método `loginWithEmailAndPassword` é semelhante ao anterior, mas é usado para autenticar um usuário existente
  /// com um email e senha. Ele recebe dois parâmetros: `email` e `password`, ambos obrigatórios (`required`).
  /// O método também retorna um `Future<Either<Failure, String>>`, indicando que pode resultar em um `Failure`
  /// (se ocorrer um erro) ou em uma `String` (se a operação for bem-sucedida).
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}