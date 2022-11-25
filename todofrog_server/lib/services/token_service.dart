import 'package:dart_frog/dart_frog.dart';

import 'package:todofrog_server/utils/jwt.dart';

class TokenService {
  static Future<Map<String, String>?> getToken(Request request) async {
    final req = await request.json() as Map<String, dynamic>;

    if (req['refresh_token'] == null) {
      throw ArgumentError('Please provide refresh token');
    }

    final payload = JwtService.getPayload({
      'Authorization': '${req['refresh_token']}',
    });

    if (payload.isEmpty) return null;

    final userId = await payload['user_id'];
    final email = await payload['user_id'];

    try {
      final accessToken = JwtService.generateToken(
        {
          'user_id': userId,
          'email': email,
        },
        const Duration(days: 1),
      );

      return {
        'access_token': accessToken,
      };
    } catch (e) {
      return null;
    }
  }
}
