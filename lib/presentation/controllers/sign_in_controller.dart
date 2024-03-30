
import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/login_response.dart';
import '../../data/services/network_caller.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  bool _obscure = true;
  String? errorMessage;
  String get getErrorMessage =>errorMessage??'Login Failed Try Again';
  bool get isSignInInProgress=>_inProgress;
  bool get getObscure=>_obscure;
  Future<bool> signIn(String email,String password)async{
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final response = await NetworkCaller.postRequest(Url.logInUrl, requestBody);
    if (response.isSuccess) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      AuthController.saveUserData(loginResponse.userData!);
      AuthController.saveUserToken(loginResponse.token!);
      _inProgress=false;
      update();
      return true;
    }
    else{
      _inProgress=false;
      update();
      return false;
    }
  }
  void changeObscure(bool obscure){ obscure?_obscure=false:_obscure=true;update();}
}