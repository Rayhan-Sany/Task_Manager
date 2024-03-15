import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

import '../../presentation/screens/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.userToken ?? ''});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            body: decodedResponse,
            statusCode: response.statusCode,
            isSuccess: true);
      } else {
        return ResponseObject(
            body: '', statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          body: '',
          statusCode: -1,
          isSuccess: false,
          errorMassage: e.toString());
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> requestBody) async {
    try {
      log(url);
      log(requestBody.toString());
      Response response = await post(Uri.parse(url),
          body: jsonEncode(requestBody),
          headers: {
            'Content-type': 'application/json',
            'token': AuthController.userToken ?? ''
          });
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            body: decodedResponse,
            statusCode: response.statusCode,
            isSuccess: true);
      } else if (response.statusCode == 401) {
      if(AuthController.userToken!=null) _moveToSignIn();
        return ResponseObject(
            body: '', statusCode: response.statusCode, isSuccess: false);
      } else {
        return ResponseObject(
            body: '', statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          body: '',
          statusCode: -1,
          isSuccess: false,
          errorMassage: e.toString());
    }
  }
  static void _moveToSignIn(){
    AuthController.clearUserData();
    if (TaskManager.globalKey.currentContext!.mounted) {
      Navigator.pushAndRemoveUntil(
          TaskManager.globalKey.currentContext!,
          MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false);
    }
  }
}
