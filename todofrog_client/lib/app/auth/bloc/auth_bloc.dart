import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    final repository = AuthRepo();

    on<Login>((event, emit) async {
      try {
        final data = await repository.login(event.login);
        await Storage.prefs.setString('token', data);
        emit(const UserLoggedIn());
      } catch (_) {
        emit(const AuthFailed(exception));
      }
    });

    on<Register>((event, emit) async {
      try {
        await repository.register(event.register);
        emit(const UserRegistered());
      } catch (_) {
        emit(const AuthFailed(exception));
      }
    });

    on<Logout>((event, emit) async {
      try {
        await Storage.prefs.clear();
        emit(const UserLoggedOut());
      } catch (_) {
        emit(const AuthFailed(exception));
      }
    });
  }
}
