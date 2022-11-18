part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.todo,
    required this.message,
  });

  final List<Todo> todo;
  final String message;
}

class HomeError extends HomeState {
  const HomeError({required this.message});

  final String message;
}
