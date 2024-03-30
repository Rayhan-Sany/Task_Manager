
import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/services/network_caller.dart';

class PinVerificationController extends GetxController{
  bool _inProgress = false;
  bool isSuccess =false;
  String? errorMessage;
  String get getErrorMessage =>errorMessage??'OTP Verify Failed Try Again';
  bool get isPinVerificationInProgress=>_inProgress;
  Future<bool> verifyOtp(String email,String otp)async{
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Url.verifyOTPUrl(otp,email));
    if (response.isSuccess) {
      if (response.body['status'] == 'success'){isSuccess=true;}
      else{
        errorMessage = response.body['data'];
      }
    }
    else{
      errorMessage =response.errorMassage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  void needUpdate(){update();}
}