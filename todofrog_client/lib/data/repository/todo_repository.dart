import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

class TodoRepo {
  Future<bool> create(Todo todo) async {
    final response = await Client().post(path: todoPath, data: todo.toJson());
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return true;
    } else {
      throw Exception(data.message);
    }
  }

  Future<List<Todo>> read() async {
    final response = await Client().get(path: todoPath);
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Todo>.from(
        (data.data as Iterable?)!
            .map((e) => Todo.fromJson(e as Map<String, dynamic>)),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> update(Todo todo) async {
    final response = await Client().put(path: todoPath, data: todo.toJson());
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return true;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> delete(int id) async {
    final response = await Client().delete(path: todoPath, data: {'id': id});
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return true;
    } else {
      throw Exception(data.message);
    }
  }
}
