import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceHelper{

  Future<String?> getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userID');
  }

  Future setUserID(String userID) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString('userID', userID);
  }

  Future<String?> getUserName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userName');
  }

  Future setUserName(String userName) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString('userName', userName);
  }
  // Future<bool> getIsFirstStart() async{
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.getBool('isFirst') ?? true;
  // }
  // Future setIsFirstStart(bool isFirst) async{
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.setBool('isFirst', isFirst);
  // }
  //
  // Future<String?> getRefreshToken() async{
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.getString('refreshToken');
  // }
  // Future<void> setRefreshToken(String token) async{
  //   final pref = await SharedPreferences.getInstance();
  //   pref.setString('refreshToken', token);
  // }
  // Future<void> removeRefreshToken() async{
  //   final pref = await SharedPreferences.getInstance();
  //   pref.remove('refreshToken');
  // }
  //
  // Future<ThemeMode> getThemeMode() async{
  //   final pref = await SharedPreferences.getInstance();
  //   return SharedUtility().stringToTheme(pref.getString('themeMode')??'light');
  // }
  //
  // Future<void> setThemeMode(ThemeMode themeMode) async{
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setString('themeMode', SharedUtility().themeToString(themeMode));
  // }

}

