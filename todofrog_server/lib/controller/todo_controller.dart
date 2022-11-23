import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:todofrog_server/models/general_response.dart';
import 'package:todofrog_server/services/todo_service.dart';

class TodoController {
  static Future<Response> read(RequestContext context) async {
    final request = context.request;

    try {
      final data = await TodoService.read(request);

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

  static Future<Response> create(RequestContext context) async {
    final request = context.request;

    try {
      final data = await TodoService.create(request);

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

  static Future<Response> update(RequestContext context) async {
    final request = context.request;

    try {
      final data = await TodoService.update(request);

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

  static Future<Response> delete(RequestContext context) async {
    final request = context.request;

    try {
      final data = await TodoService.delete(request);

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
}
