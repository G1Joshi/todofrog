import 'connection.dart';

class Query {
  static Future<void> table() async {
    await (await Connection.getConnection).query(
      '''
        CREATE TABLE IF NOT EXISTS todos (
            id serial,
            title text NOT NULL,
            description text NOT NULL,
            priority integer NOT NULL,
            is_done boolean NOT NULL
        )
      ''',
    );
  }

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
}
