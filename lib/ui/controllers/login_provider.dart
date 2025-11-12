import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginProvider extends ChangeNotifier {
  bool isSuccess = false;
  bool _loginInProgress = false;
  String? _errorMessage;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> logIn(String email, String password) async {
    _loginInProgress = true;
    notifyListeners();
    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "password": password,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.loginUrl,
      body: requestBody,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel model = UserModel.fromJson(response.responseData["data"]);
      String accessToken = response.responseData["token"];

      await AuthController.saveUserData(model, accessToken);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _loginInProgress = false;
    notifyListeners();
    return isSuccess;
  }

}