import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../auth/auth.dart';
import '../models/general_response.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return register(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> register(RequestContext context) async {
  final request = context.request;

  try {
    final data = await Auth.register(request);

    if (data) {
      return Response.json(
        statusCode: HttpStatus.created,
        body: GeneralResponse(
          status: true,
        ),
      );
    } else {
      return Response.json(
        statusCode: HttpStatus.nonAuthoritativeInformation,
        body: GeneralResponse(
          status: false,
          message: 'User Already Registered',
        ),
      );
    }
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
