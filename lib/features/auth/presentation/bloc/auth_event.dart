part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailAndPassword extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpWithEmailAndPassword({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
