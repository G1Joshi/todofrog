import 'package:todofrog_server/database/connection.dart';

class Tables {
  static Future<void> tableTodos() async {
    await (await Connection.getConnection).query(
      '''
        CREATE TABLE IF NOT EXISTS todos (
            id serial,
            user_id integer NOT NULL references users(id),
            title text NOT NULL,
            description text NOT NULL,
            priority integer NOT NULL,
            is_done boolean NOT NULL
        )
      ''',
    );
  }

  static Future<void> tableUsers() async {
    await (await Connection.getConnection).query(
      '''
        CREATE TABLE IF NOT EXISTS users (
            id serial primary key,
            name text NOT NULL,
            email text NOT NULL,
            password text NOT NULL,
            is_active boolean NOT NULL
        )
      ''',
    );
  }
}
