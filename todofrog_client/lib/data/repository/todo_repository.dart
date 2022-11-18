import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

class TodoRepo {
  Future<bool> create(Todo todo) async {
    final response = await Client().post(path: todoPath, data: todo.toJson());
    final result = response['data'] as bool;
    return result;
  }

  Future<List<Todo>> read() async {
    final response = await Client().get(path: todoPath);
    final result = List<Todo>.from(
      (response['data'] as Iterable)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>)),
    );
    return result;
  }

  Future<bool> update(Todo todo) async {
    final response = await Client().put(path: todoPath, data: todo.toJson());
    final result = response['data'] as bool;
    return result;
  }

  Future<bool> delete(int id) async {
    final response = await Client().delete(path: todoPath, data: {'id': id});
    final result = response['data'] as bool;
    return result;
  }
}
