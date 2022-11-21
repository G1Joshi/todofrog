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
        if (data == null) {
          emit(const AuthFailed('Unable to login, Please try again later'));
        } else {
          await Storage.prefs.setString('token', data);
          emit(const UserLoggedIn());
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<Register>((event, emit) async {
      try {
        final data = await repository.register(event.register);
        if (data) {
          emit(const UserRegistered());
        } else {
          emit(const AuthFailed('Unable to register, Please try again later'));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      try {
        await Storage.prefs.clear();
        emit(const UserLoggedOut());
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }
}
