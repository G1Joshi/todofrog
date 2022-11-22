import 'package:dart_frog/dart_frog.dart';

import '../database/query.dart';
import 'jwt.dart';

class Auth {
  static Future<String?> login(Request request) async {
    final req = await request.json() as Map<String, dynamic>;

    if (req['email'] == null) {
      throw ArgumentError('Please provide Email');
    }
    if (req['password'] == null) {
      throw ArgumentError('Please provide Password');
    }

    try {
      final userId =
          await Query.login("'${req["email"]}'", "'${req["password"]}'");
      final token = JwtService.generateToken({'user_id': userId});

      return token;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> register(Request request) async {
    final req = await request.json() as Map<String, dynamic>;

    final creds = <String>[];

    if (req['email'] == null) {
      throw ArgumentError('Please provide Email');
    }
    if (req['password'] == null) {
      throw ArgumentError('Please provide Password');
    }

    final userExists = await Query.checkAccount("'${req["email"]}'");
    if (userExists) return false;

    for (final element in req.keys) {
      if (element == 'id') continue;
      creds.add("'${req[element]}'");
    }

    final data = creds.join(',');
    await Query.register(data);

    return true;
  }
}
