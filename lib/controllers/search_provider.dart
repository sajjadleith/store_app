import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/model/book_model.dart';
import 'package:store/repo/api_repo.dart';

class SearchProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();

  List<BookModel> _allBooks = [];

  GeneralState<List<BookModel>> generalState = GeneralState(requestState: RequestState.empty);

  Future<void> fetchBooks() async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final data = await repo.getData();
      _allBooks = data;

      generalState = GeneralState(requestState: RequestState.success, data: data);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }

    notifyListeners();
  }

  void search(String value) {
    if (value.isEmpty) {
      generalState = GeneralState(requestState: RequestState.success, data: _allBooks);
    } else {
      final filtered = _allBooks.where((book) {
        return book.title.toLowerCase().contains(value.toLowerCase()) ||
            book.autherName.toLowerCase().contains(value.toLowerCase());
      }).toList();

      generalState = GeneralState(requestState: RequestState.success, data: filtered);
    }
    notifyListeners();
  }
}
