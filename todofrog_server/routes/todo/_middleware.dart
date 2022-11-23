import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todofrog_server/utils/jwt.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final headers = context.request.headers;
    final isVerified = JwtService.verifyToken(headers);
    if (isVerified) {
      final response = await handler(context);
      return response;
    } else {
      return Response(statusCode: HttpStatus.unauthorized);
    }
  };
}
