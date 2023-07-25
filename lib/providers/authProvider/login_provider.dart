import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

class LoginProvider extends StateNotifier<dynamic> {
  LoginProvider() : super({});
  SharedPreferences? prefs;

  Future<dynamic> login(phone, password) async {
    try {
      final response = await dio.get("http://localhost:3000/api/v1/auth/login",
          data: {"phone": phone, "password": password});
      prefs = await SharedPreferences.getInstance();
      prefs?.setString('authToken', response.data['message']['authToken']);
      return response.data;
    } catch (err) {
      throw Exception(err);
    }
  }
}
