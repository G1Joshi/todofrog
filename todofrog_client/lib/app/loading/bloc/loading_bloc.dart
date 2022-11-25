import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/config/config.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingInitial()) {
    on<GetStatus>((event, emit) {
      if (Storage.prefs.getString('access_token') == null) {
        emit(const NotAuthenticated());
      } else {
        emit(const Authenticated());
      }
    });
  }
}
