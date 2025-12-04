import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/repo/api_repo.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState();
  void getDataCategory() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      final data = await repo.getCategoryData();
      if (data.isEmpty) {
        generalState = GeneralState(requestState: RequestState.empty);
        return;
      }

      generalState = GeneralState(requestState: RequestState.success, data: data);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }

  int selectedIndex = 0;
  void selectCategor(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
