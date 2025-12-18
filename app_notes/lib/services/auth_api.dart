import 'package:dio/dio.dart';
import '../utils/shared_pref.dart';

class AuthApi {
  final dio = Dio(BaseOptions(
    baseUrl: "https://long-palpitant-jinglingly.ngrok-free.dev/api",
    headers: {
      "Accept": "application/json",
      "ngrok-skip-browser-warning": "true",
    },
  ));

  Future<bool> login(String email, String password) async {
    try {
      final res = await dio.post('/login', data: {
        "email": email,
        "password": password,
      });

      final token = res.data["token"];
      await SharedPref.saveToken(token);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    final token = await SharedPref.getToken();

    await dio.post(
      "/logout",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    SharedPref.clearToken();
  }

  
  Future<bool> register(String name, String email, String password) async {
    try {
      final res = await dio.post('/register', data: {
        "name": name,
        "email": email,
        "password": password,
      });

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
