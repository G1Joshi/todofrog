import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

class AuthRepo {
  Future<String> login(UserLogin login) async {
    final response = await Client().post(path: loginPath, data: login.toJson());
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result =
          (data.data as Map<String, dynamic>?)!['access_token'] as String;
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> register(UserRegister register) async {
    final response =
        await Client().post(path: registerPath, data: register.toJson());
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return true;
    } else {
      throw Exception(data.message);
    }
  }
}
