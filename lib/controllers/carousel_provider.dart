import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/repo/api_repo.dart';

class CarouselProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState(requestState: RequestState.empty);
  void providedData() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      final data = await repo.getCarouselData();
      generalState = GeneralState(requestState: RequestState.success, data: data);
    } catch (e) {
      print("CAROUSEL ERROR: $e");
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }
}
