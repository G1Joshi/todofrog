import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final method = context.request.method.value;
  return Response(body: 'Hey there!, You made a $method request.');
}
