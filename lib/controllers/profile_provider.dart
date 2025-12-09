import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/model/profile_model.dart';
import 'package:store/repo/api_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();

  GeneralState<ProfileModel> generalState = GeneralState(requestState: RequestState.empty);

  Future<void> getProfile() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final data = await repo.getProfile();

      generalState = GeneralState(requestState: RequestState.success, data: data);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }

    notifyListeners();
  }
}
