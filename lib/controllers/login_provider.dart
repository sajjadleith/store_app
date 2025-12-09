import 'package:flutter/material.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/main.dart';
import 'package:store/model/login_model.dart';
import 'package:store/repo/api_repo.dart';
import 'package:store/screens/home_screen.dart';

import '../core/enums/request_state.dart';
import '../core/generale_state.dart';

class LoginProvider extends ChangeNotifier {
  GeneralState generalState = GeneralState(requestState: RequestState.empty);
  final ApiRepo repo = ApiRepo();

  Future<void> login(String email, String password) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final data = await repo.login(LoginModel(email: email, password: password));
      final token = data['data']?['token'] as String?;
      if (token != null) {
        await SharedPrefServcie.setData(AppConstain.token, token);
        debugPrint("✅ TOKEN SAVED => $token");
      }

      generalState = GeneralState(requestState: RequestState.success, data: data);
      notifyListeners();
    } catch (e) {
      String errorMessage = "Login failed";

      final err = e.toString().toLowerCase();
      if (err.contains("incorrect password")) {
        errorMessage = "Incorrect password";
      }

      debugPrint("LOGIN ERROR => $err");

      generalState = GeneralState(requestState: RequestState.error, error: errorMessage);
      notifyListeners();
    }
  }
}
