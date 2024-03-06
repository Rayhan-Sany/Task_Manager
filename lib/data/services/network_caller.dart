import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager/data/models/response_object.dart';

class NetworkCaller {
 static Future<ResponseObject> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url));
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
          body:jsonEncode(requestBody), headers: {'Content-type':'application/json'});
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
}