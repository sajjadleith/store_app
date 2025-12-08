import 'package:flutter/material.dart';
import 'package:store/main.dart';
import 'package:store/model/login_model.dart';
import 'package:store/repo/api_repo.dart';
import 'package:store/screens/home_screen.dart';

import '../core/enums/request_state.dart';
import '../core/generale_state.dart';

class LoginProvider extends ChangeNotifier {
  GeneralState generalState = GeneralState(requestState: RequestState.empty);
  final ApiRepo repo = ApiRepo();

  void login(String emailController, String passwordController, BuildContext context) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final data = await repo.login(
        LoginModel(email: emailController, password: passwordController),
      );
      print("hghfhgfhgffghfghgfhhfgfhghfyg");

      print(data);

      generalState = GeneralState(requestState: RequestState.success, data: data);

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MyApp()),
          (route) => false,
        );
      }
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }
}
