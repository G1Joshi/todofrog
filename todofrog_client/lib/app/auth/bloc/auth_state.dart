part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class UserLoggedIn extends AuthState {
  const UserLoggedIn();
}

class UserRegistered extends AuthState {
  const UserRegistered();
}

class UserLoggedOut extends AuthState {
  const UserLoggedOut();
}

class AuthFailed extends AuthState {
  const AuthFailed(this.message);

  final String message;
}
