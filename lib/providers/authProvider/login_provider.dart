import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

class LoginNotifierProvider extends StateNotifier<dynamic> {
  LoginNotifierProvider() : super({});
  SharedPreferences? prefs;

  Future<dynamic> login(phone, password) async {
    try {
      final response = await dio.post("http://localhost:3000/api/v1/auth/login",
          data: {"phone": phone, "password": password, "channel": "app"});
      if (response.statusCode == 200) {
        prefs = await SharedPreferences.getInstance();
        prefs?.setString('authToken', response.data['message']['authToken']);
        state = response.data['message']['authToken'];
        return response.data;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}

final loginProvider = StateNotifierProvider((ref) => LoginNotifierProvider());
