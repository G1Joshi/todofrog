import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../auth/jwt.dart';
import '../database/database.dart';
import '../models/general_response.dart';

Future<Response> onRequest(RequestContext context) async {
  final headers = context.request.headers;
  final isVerified = JwtService.verifyToken(headers);
  if (isVerified) {
    final method = context.request.method;
    switch (method) {
      case HttpMethod.get:
        return read(context);
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
      body: GeneralResponse(
        status: false,
        message: 'User Is Not Authorized, Please Login',
      ),
    );
  }
}

Future<Response> read(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.read(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: GeneralResponse(
        status: false,
        data: e.toString(),
      ),
    );
  }
}

Future<Response> create(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.create(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: GeneralResponse(
        status: false,
        message: e.toString(),
      ),
    );
  }
}

Future<Response> update(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.update(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: GeneralResponse(
        status: false,
        message: e.toString(),
      ),
    );
  }
}

Future<Response> delete(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Database.delete(request);

    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: GeneralResponse(
        status: false,
        message: e.toString(),
      ),
    );
  }
}
