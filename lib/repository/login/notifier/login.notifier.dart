import 'package:flutter/material.dart';
import 'package:qcamytraders/repository/login/model/login.model.dart';
import 'package:qcamytraders/repository/login/networking/login.networking.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginNetworking _loginNetworking = LoginNetworking();

  bool isLoading = false;

  late LoginModel loginModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  loginUser({required dynamic userName, required String password}) async {
    loading(true);

    try {
      loginModel = await _loginNetworking.loginUser(
          userName: userName, password: password);

      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
