part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {
  const LoadingState();
}

class LoadingInitial extends LoadingState {
  const LoadingInitial();
}

class Authenticated extends LoadingState {
  const Authenticated();
}

class NotAuthenticated extends LoadingState {
  const NotAuthenticated();
}
