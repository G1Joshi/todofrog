part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class LoadTodo extends HomeEvent {
  const LoadTodo();
}

class CreateTodo extends HomeEvent {
  const CreateTodo(this.todo);

  final Todo todo;
}

class UpdateTodo extends HomeEvent {
  const UpdateTodo(this.todo);

  final Todo todo;
}

class DeleteTodo extends HomeEvent {
  const DeleteTodo(this.id);

  final int id;
}
