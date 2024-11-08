import 'package:get/get_state_manager/get_state_manager.dart';

import '../../data/models/network_response.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String Password) async {
    bool isSuccess = false;
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': Password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    _inProgress = true;
    update();
    if (response.isSuccess) {
      await AuthController.saveUserData(
          UserModel.fromJson(response.responseData['data']));
      await AuthController.saveAccessToken(response.responseData['token']);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
