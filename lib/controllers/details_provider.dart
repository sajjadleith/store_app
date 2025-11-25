import 'package:flutter/material.dart';

import '../core/enums/request_state.dart';
import '../core/generale_state.dart';
import '../repo/api_repo.dart';

class DetailsProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState();

  void fetchData(String id) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      final data = await repo.getCommentData(id);

      generalState = GeneralState(
        requestState: RequestState.success,
        data: data,
      );
    } catch (e) {
      generalState = GeneralState(
        requestState: RequestState.error,
        error: e.toString(),
      );
    }
    notifyListeners();
  }
}
