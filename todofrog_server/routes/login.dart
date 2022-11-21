import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../auth/auth.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return login(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> login(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Auth.login(request);

    if (data == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: <String, dynamic>{'error': 'User Not Found, Please Register'},
      );
    } else {
      return Response.json(
        statusCode: HttpStatus.created,
        body: <String, dynamic>{
          'data': {'token': data}
        },
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: <String, dynamic>{'error': '$e'},
    );
  }
}
