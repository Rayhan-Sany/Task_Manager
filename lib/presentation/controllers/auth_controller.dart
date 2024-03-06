import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_data.dart';

class AuthController{
  static Future<void> saveUserData(UserData userData)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userData',jsonEncode(userData.toJson()));
  }
  static Future<UserData?> getUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userData');
    if(result==null) return null;
    return UserData.fromJson(jsonDecode(result));
  }
  static Future<void> saveUserToken(String? token)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userToken',jsonEncode(token));
  }
  static Future<String?> getUserToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userToken');
    if(result==null) return null;
    return result;
  }
  static Future<bool>isUserLoggedIn()async{
    String? result = await getUserToken();
    if(result==null) return false;
    return true;
  }
  static Future<void>clearUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}