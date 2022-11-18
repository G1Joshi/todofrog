import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/data/data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    final repository = TodoRepo();
    var todo = <Todo>[];

    Future<void> refresh() async {
      todo = await repository.read();
    }

    on<LoadTodo>((event, emit) async {
      try {
        await refresh();
        emit(HomeLoaded(todo: todo, message: 'Todo Loaded'));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<CreateTodo>((event, emit) async {
      try {
        final data = await repository.create(event.todo);
        if (data) {
          await refresh();
          emit(HomeLoaded(todo: todo, message: 'Todo Added'));
        } else {
          emit(HomeLoaded(todo: todo, message: 'Todo Not Added'));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      try {
        final data = await repository.update(event.todo);
        if (data) {
          await refresh();
          emit(HomeLoaded(todo: todo, message: 'Todo Updated'));
        } else {
          emit(HomeLoaded(todo: todo, message: 'Todo Not Updated'));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        final data = await repository.delete(event.id);
        if (data) {
          await refresh();
          emit(HomeLoaded(todo: todo, message: 'Todo Deleted'));
        } else {
          emit(HomeLoaded(todo: todo, message: 'Todo Not Deleted'));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
