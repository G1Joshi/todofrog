import 'package:postgres/postgres.dart';

class Connection {
  static PostgreSQLConnection? _connection;

  static Future<PostgreSQLConnection> get getConnection async {
    if (_connection == null) await _openConnection();
    return _connection!;
  }

  static Future<void> get disconnect async {
    if (_connection != null) await _closeConnection();
  }

  static Future<void> _openConnection() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5435,
      'todofrog',
      username: 'todofrog',
      password: 'todofrog',
    );
    await _connection?.open();
  }

  static Future<void> _closeConnection() async {
    await _connection?.close();
  }
}
