import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/model/favourit_model.dart';
import 'package:store/repo/api_repo.dart';

class FavouriteProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();

  GeneralState<List<FavouriteModel>> generalState = GeneralState(requestState: RequestState.empty);

  Future<void> fetchFavourites() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final data = await repo.getFavourites();

      generalState = GeneralState(requestState: RequestState.success, data: data);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }

  Future<void> addFavourite(String bookId) async {
    try {
      await repo.addToFavourite(bookId);
      await fetchFavourites();
    } catch (e) {
      debugPrint("ADD FAV ERROR => $e");
    }
  }
}
