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
      notifyListeners();

      final data = await repo.register(
        RegisterModel(
          username: usernameController,
          email: emailController,
          password: passwordController,
        ),
      );

      debugPrint("REGISTER SUCCESS DATA => $data");

      generalState = GeneralState(requestState: RequestState.success, data: data);
      notifyListeners();

      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    } catch (e) {
      final err = e.toString().toLowerCase();
      debugPrint("REGISTER CATCH ERROR => $err");

      String message = "Register failed";

      if (err.contains("already") || err.contains("exists") || err.contains("exist")) {
        message = "User already exists, try to login";
      }

      generalState = GeneralState(requestState: RequestState.error, error: message);
      notifyListeners();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
