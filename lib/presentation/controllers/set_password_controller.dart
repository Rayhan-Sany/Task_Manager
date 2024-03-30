
import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/services/network_caller.dart';

class SetPasswordController extends GetxController{
  bool _obscure=true;
  bool _inProgress = false;
  String? errorMessage;
  String get getErrorMessage =>errorMessage??'Password Setup Failed Try Again';
  bool get isSetPasswordInProgress=>_inProgress;
  bool get getObscure=>_obscure;
  Future<bool> setPassword(Map<String, dynamic> requestBody)async{
    _inProgress = true;
    bool isSuccess =false;
    update();
    final response =  await NetworkCaller.postRequest(
        Url.setPasswordUrl, requestBody);
    if (response.isSuccess) {
      if (response.body['status'] == 'success'){isSuccess=true;}
      else{
        errorMessage = response.body['data'];
      }
    }
    else{
      errorMessage = response.errorMassage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  void obscure(bool obscure){_obscure =obscure?false:true;update(); }
}