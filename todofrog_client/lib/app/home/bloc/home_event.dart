part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class LoadTodo extends HomeEvent {
  const LoadTodo({this.show = true});

  final bool show;
}

class CreateTodo extends HomeEvent {
  const CreateTodo(this.todo, {this.show = true});

  final Todo todo;
  final bool show;
}

class UpdateTodo extends HomeEvent {
  const UpdateTodo(this.todo, {this.show = true});

  final Todo todo;
  final bool show;
}

class DeleteTodo extends HomeEvent {
  const DeleteTodo(this.id, {this.show = true});

  final int id;
  final bool show;
}
