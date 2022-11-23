import 'package:todofrog_server/database/connection.dart';

class Query {
  static Future<void> create(String value) async {
    await (await Connection.getConnection).query(
      '''
        INSERT INTO todos (
                user_id,
                title,
                description,
                priority,
                is_done
            )
        VALUES ($value)
      ''',
    );
  }

  static Future<List<Map<String, Map<String, dynamic>>>> read(int id) async {
    final results = await (await Connection.getConnection).mappedResultsQuery(
      '''
        SELECT todos.id,
            title,
            description,
            priority,
            is_done
        from todos
            INNER JOIN users ON users.id = todos.user_id
        WHERE users.id = $id
        ORDER BY id
      ''',
    );

    return results;
  }

  static Future<void> update(String value, int id) async {
    await (await Connection.getConnection).query(
      '''
        UPDATE todos
        SET $value
        WHERE id = $id
      ''',
    );
  }

  static Future<void> delete(int id) async {
    await (await Connection.getConnection).query(
      '''
        DELETE FROM todos
        WHERE id = $id
      ''',
    );
  }

  static Future<bool> checkAccount(String email) async {
    final result = await (await Connection.getConnection).query(
      '''
        SELECT COUNT(*)
        FROM users
        WHERE email = $email
      ''',
    );

    return result.first.first != 0;
  }

  static Future<int?> login(String email, String password) async {
    final result = await (await Connection.getConnection).query(
      '''
        SELECT id
        FROM users
        WHERE email = $email
            AND password = $password
      ''',
    );

    return result.first.first as int;
  }

  static Future<void> register(String value) async {
    await (await Connection.getConnection).query(
      '''
        INSERT INTO users (
                name,
                email,
                password,
                is_active
            )
        VALUES ($value)
      ''',
    );
  }
}
