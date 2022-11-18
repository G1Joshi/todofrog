import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<CreateTodo>((event, emit) async {
      String? message;
      try {
        final data = await repository.create(event.todo);
        if (data) {
          await refresh();
          if (event.show) message = 'Todo Added';
          emit(HomeLoaded(todo: todo, message: message));
        } else {
          if (event.show) message = 'Todo Not Added';
          emit(HomeLoaded(todo: todo, message: message));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      String? message;
      try {
        final data = await repository.update(event.todo);
        if (data) {
          await refresh();
          if (event.show) if (event.show) message = 'Todo Updated';
          emit(HomeLoaded(todo: todo, message: message));
        } else {
          if (event.show) message = 'Todo Not Updated';
          emit(HomeLoaded(todo: todo, message: message));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      String? message;
      try {
        final data = await repository.delete(event.id);
        if (data) {
          await refresh();
          if (event.show) message = 'Todo Deleted';
          emit(HomeLoaded(todo: todo, message: message));
        } else {
          if (event.show) message = 'Todo Not Deleted';
          emit(HomeLoaded(todo: todo, message: message));
        }
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
