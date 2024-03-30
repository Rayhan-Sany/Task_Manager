
import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/user_data.dart';
import '../../data/services/network_caller.dart';
import 'auth_controller.dart';

class UpdateProfileController extends GetxController{
  bool _inProgress = false;
  String? errorMessage;
  String get getErrorMessage =>errorMessage??'Profile Update Failed';
  bool get isUpdateProfileInProgress=>_inProgress;
  Future<bool> updateProfile(Map<String, dynamic> requestBody)async{
    _inProgress = true;
    bool isSuccess =false;
    update();
    final response =  await NetworkCaller.postRequest(Url.updateProfileUrl,requestBody);
    if (response.isSuccess) {
      UserData userData = UserData(
          email:requestBody['email'],
          firstName: requestBody['firstName'],
          lastName: requestBody['lastName'],
          mobile: requestBody['mobile'],
          photo:requestBody['photo']);
      AuthController.saveUserData(userData);
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