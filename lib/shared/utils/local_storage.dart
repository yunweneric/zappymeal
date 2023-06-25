import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zappy_meal/models/login/verification_res_model.dart';

import 'logger_util.dart';

class LocalPrefs {
  // ** -----------------------------**//
  // ** Saved Preferences **//
  // ** -----------------------------**//

  static saveInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool('init', true);
  }

  static saveUserInfo(String userInfo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user_info', userInfo);
  }

  static saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  static void saveThemePreset(String preset) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('preset', preset);
  }

  static saveUserLocation({required String location}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('location', location);
    logI('saved ocation:  $location');
  }
  // ** -----------------------------**//
  // ** Get Preferences **//
  // ** -----------------------------**//

  static Future<bool> getInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final isInit = sharedPreferences.getBool('init');
    return isInit == null ? false : isInit;
  }

  static Future<VerificationResponse?> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? res = sharedPreferences.getString('user_info');
    if (res != null && res != "") {
      Map<String, dynamic> data = json.decode(res);
      return VerificationResponse.fromJson(data);
    }
    return null;
  }

  static getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user_info', '');
    sharedPreferences.setString('token', '');
  }

  static getSavedLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('location');
  }
}
