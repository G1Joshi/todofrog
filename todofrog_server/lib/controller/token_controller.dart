import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:todofrog_server/models/general_response.dart';
import 'package:todofrog_server/services/token_service.dart';

class TokenController {
  static Future<Response> generate(RequestContext context) async {
    final request = context.request;

    try {
      final data = await TokenService.getToken(request);

      if (data == null) {
        return Response.json(
          statusCode: HttpStatus.nonAuthoritativeInformation,
          body: GeneralResponse(
            status: false,
            message: 'Invalid Refresh Token',
          ),
        );
      } else {
        return Response.json(
          statusCode: HttpStatus.created,
          body: GeneralResponse(
            status: true,
            data: data,
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
}
