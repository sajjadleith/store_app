import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/repo/api_repo.dart';

class ChangePasswordProvider extends ChangeNotifier {
  GeneralState<bool> generalState = GeneralState(requestState: RequestState.empty);

  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    generalState = GeneralState(requestState: RequestState.loading);
    notifyListeners();

    try {
      final success = await ApiRepo().updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      generalState = GeneralState(requestState: RequestState.success, data: success);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }

    notifyListeners();
  }
}
