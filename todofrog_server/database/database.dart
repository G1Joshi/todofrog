import 'package:dart_frog/dart_frog.dart';

import 'query.dart';

class Database {
  static Future<bool> create(Request request) async {
    final req = await request.json() as Map<String, dynamic>;
    final todos = <String>[];

    for (final element in req.keys) {
      if (element == 'id') continue;
      todos.add("'${req[element]}'");
    }

    final data = todos.join(',');
    await Query.create(data);

    return true;
  }

  static Future<List<Object>> read() async {
    final results = await Query.read();
    final todos = <Object>[];

    for (final element in results) {
      todos.add(element['todos']!);
    }

    return todos;
  }

  static Future<bool> update(Request request) async {
    final req = await request.json() as Map<String, dynamic>;
    final todos = <String>[];

    if (req['id'] == null) {
      throw ArgumentError('Please provide ID');
    }

    for (final element in req.keys) {
      todos.add("$element = '${req[element]}'");
    }

    final data = todos.join(',');
    await Query.update(data, req['id'] as int);

    return true;
  }

  static Future<bool> delete(Request request) async {
    final req = await request.json() as Map<String, dynamic>;

    if (req['id'] == null) {
      throw ArgumentError('Please provide ID');
    }

    await Query.delete(req['id'] as int);

    return true;
  }
}