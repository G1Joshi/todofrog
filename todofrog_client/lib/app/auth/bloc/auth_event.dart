part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class Login extends AuthEvent {
  const Login(this.login);

  final UserLogin login;
}

class Register extends AuthEvent {
  const Register(this.register);

  final UserRegister register;
}

class Logout extends AuthEvent {
  const Logout();
}
