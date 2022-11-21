import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../auth/jwt.dart';
import '../database/database.dart';

Future<Response> onRequest(RequestContext context) async {
  final headers = context.request.headers;
  final isVerified = JwtService.verifyToken(headers);
  if (isVerified) {
    final method = context.request.method;
    switch (method) {
      case HttpMethod.get:
        return read();
      case HttpMethod.post:
        return create(context);
      case HttpMethod.put:
        return update(context);
      case HttpMethod.delete:
        return delete(context);
      case HttpMethod.head:
      case HttpMethod.options:
      case HttpMethod.patch:
        return Response(statusCode: HttpStatus.methodNotAllowed);
    }
  } else {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: <String, dynamic>{'error': 'User Is Not Authorized, Please Login'},
    );
  }
}

Future<Response> read() async {
  try {
    final data = await Database.read();

    return Response.json(
      statusCode: HttpStatus.created,
      body: <String, dynamic>{'data': data},
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: <String, dynamic>{'error': '$e'},
    );
  }
}

Future<Response> create(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.create(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: <String, dynamic>{'data': data},
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: <String, dynamic>{'error': '$e'},
    );
  }
}

Future<Response> update(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.update(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: <String, dynamic>{'data': data},
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: <String, dynamic>{'error': '$e'},
    );
  }
}

Future<Response> delete(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.delete(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: <String, dynamic>{'data': data},
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: <String, dynamic>{'error': '$e'},
    );
  }
}
