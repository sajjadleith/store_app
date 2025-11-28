import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/model/register_model.dart';
import 'package:store/repo/api_repo.dart';
import 'package:store/screens/login_screen.dart';

class RegisterProvider extends ChangeNotifier {
  GeneralState generalState = GeneralState(requestState: RequestState.empty);
  final ApiRepo repo = ApiRepo();
  void register(
    String usernameController,
    String emailController,
    String passwordController,
    BuildContext context,
  ) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      final data = await repo.register(
        RegisterModel(
          username: usernameController,
          email: emailController,
          password: passwordController,
        ),
      );
      print(data);
      generalState = GeneralState(
        requestState: RequestState.success,
        data: data,
      );
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
    notifyListeners();
  }
}
