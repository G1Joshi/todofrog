import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todofrog_server/controller/todo_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  switch (method) {
    case HttpMethod.get:
      return TodoController.read(context);
    case HttpMethod.post:
      return TodoController.create(context);
    case HttpMethod.put:
      return TodoController.update(context);
    case HttpMethod.delete:
      return TodoController.delete(context);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
