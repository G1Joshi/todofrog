import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todofrog_server/controller/auth_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return AuthController.login(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
