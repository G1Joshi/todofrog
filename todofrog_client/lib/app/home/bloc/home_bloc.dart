import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    final repository = TodoRepo();
    var todo = <Todo>[];

    Future<void> refresh() async => todo = await repository.read();

    on<LoadTodo>((event, emit) async {
      String? message;
      try {
        await refresh();
        if (event.show) message = 'Todo Loaded';
        emit(HomeLoaded(todo: todo, message: message));
      } catch (_) {
        emit(const HomeError(exception));
      }
    });

    on<CreateTodo>((event, emit) async {
      String? message;
      try {
        await repository.create(event.todo);
        await refresh();
        if (event.show) message = 'Todo Added';
        emit(HomeLoaded(todo: todo, message: message));
      } catch (_) {
        emit(const HomeError(exception));
      }
    });

    on<UpdateTodo>((event, emit) async {
      String? message;
      try {
        await repository.update(event.todo);
        await refresh();
        if (event.show) if (event.show) message = 'Todo Updated';
        emit(HomeLoaded(todo: todo, message: message));
      } catch (_) {
        emit(const HomeError(exception));
      }
    });

    on<DeleteTodo>((event, emit) async {
      String? message;
      try {
        await repository.delete(event.id);
        await refresh();
        if (event.show) message = 'Todo Deleted';
        emit(HomeLoaded(todo: todo, message: message));
      } catch (_) {
        emit(const HomeError(exception));
      }
    });
  }
}
