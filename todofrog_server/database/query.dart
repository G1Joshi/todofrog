import 'connection.dart';

class Query {
  static Future<void> create(String value) async {
    await (await Connection.getConnection).query(
      '''
        INSERT INTO todos (
                title,
                description,
                priority,
                is_done
            )
        VALUES ($value)
      ''',
    );
  }

  static Future<List<Map<String, Map<String, dynamic>>>> read() async {
    final results = await (await Connection.getConnection).mappedResultsQuery(
      '''
        SELECT *
        from todos
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

  static Future<bool> checkAccount(
    String email,
  ) async {
    final result = await (await Connection.getConnection).query(
      '''
        SELECT *
        FROM users
        WHERE email = $email
      ''',
    );

    return result.isNotEmpty;
  }

  static Future<bool> login(
    String email,
    String password,
  ) async {
    final result = await (await Connection.getConnection).query(
      '''
        SELECT *
        FROM users
        WHERE email = $email
            AND password = $password
      ''',
    );

    return result.isEmpty;
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
