import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:todofrog_server/models/general_response.dart';
import 'package:todofrog_server/services/auth_service.dart';

class AuthController {
  static Future<Response> login(RequestContext context) async {
    final request = context.request;

    try {
      final data = await AuthService.login(request);

      if (data == null) {
        return Response.json(
          statusCode: HttpStatus.nonAuthoritativeInformation,
          body: GeneralResponse(
            status: false,
            message: 'User Not Found, Please Register',
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

  static Future<Response> register(RequestContext context) async {
    final request = context.request;

    try {
      final data = await AuthService.register(request);

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
}
