import 'package:todofrog_client/config/config.dart';
import 'package:todofrog_client/data/data.dart';

class AuthRepo {
  Future<String?> login(UserLogin login) async {
    try {
      final response =
          await Client().post(path: loginPath, data: login.toJson());
      final result =
          (response['data'] as Map<String, dynamic>)['token'] as String;
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<bool> register(UserRegister register) async {
    try {
      await Client().post(path: registerPath, data: register.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }
}
