
import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/services/network_caller.dart';

class SignUpController extends GetxController{
  bool _inProgress = false;
  String? errorMessage;
  String get getErrorMessage =>errorMessage??'Sign Up Failed Try Again';
  bool get isSignUpInProgress=>_inProgress;
  Future<bool> signUp(Map<String, dynamic> requestBody)async{
    _inProgress = true;
    bool isSuccess =false;
    update();
    final response =  await NetworkCaller.postRequest(Url.registrationUrl, requestBody);
    if (response.isSuccess) {
      isSuccess=true;
    }
    else{
     errorMessage = response.errorMassage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}