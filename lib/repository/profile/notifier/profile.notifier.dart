import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/profile/model/profile.model.dart';
import 'package:qcamytraders/repository/profile/networking/profile.networking.dart';

class ProfileNotifier extends ChangeNotifier {
  final ProfileNetworking _profileNetworking = ProfileNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late ProfileModel profileModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getProfile() async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      profileModel = await _profileNetworking.getProfile(token: token!);

      loading(false);
      return profileModel;
    } catch (e) {
      loading(false);
    }
  }
}
