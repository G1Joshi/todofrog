import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService {
  static String? _getToken(Map<String, String> headers) {
    String? token;
    if (headers.containsKey('Authorization')) {
      final header = headers['Authorization'].toString().split(' ');
      if (header[0].contains('Bearer')) {
        token = header[1];
      } else {
        token = header[0];
      }
    }
    return token;
  }

  static String generateToken(Map<String, dynamic> payload) {
    final jwt = JWT(payload);
    final token = jwt.sign(SecretKey(''));
    return token;
  }

  static bool verifyToken(Map<String, String> headers) {
    final token = _getToken(headers);
    if (token != null) {
      try {
        JWT.verify(token, SecretKey(''));
        return true;
      } catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }

  static Map<String, dynamic> getPayload(Map<String, String> headers) {
    final token = _getToken(headers);
    if (token != null) {
      try {
        final jwt = JWT.verify(token, SecretKey(''));
        return jwt.payload as Map<String, dynamic>;
      } catch (_) {
        return {};
      }
    } else {
      return {};
    }
  }
}
