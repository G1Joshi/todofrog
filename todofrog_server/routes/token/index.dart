import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todofrog_server/controller/token_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return TokenController.generate(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
