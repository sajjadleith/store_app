import 'package:flutter/cupertino.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/repo/api_repo.dart';

class BookProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState();

  void fetchData() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      final data = await repo.getData();
      if (data.isEmpty) {
        generalState = GeneralState(requestState: RequestState.empty);
        return;
      }

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
