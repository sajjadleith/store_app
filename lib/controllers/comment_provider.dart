import 'package:flutter/material.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/model/comment_model.dart';
import 'package:store/model/comment_param_model.dart';
import 'package:store/repo/api_repo.dart';

class CommentProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState();
  GeneralState addCommentState = GeneralState();

  void fetchData(String id) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);

      final List<CommentModel> comments = await repo.getCommentDatas(id);

      generalState = GeneralState(
        requestState: RequestState.success,
        data: comments,
      );
    } catch (e) {
      generalState = GeneralState(
        requestState: RequestState.error,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

bool isLoadingComment = false;
  void addComment(String content, String bookId) async {
    isLoadingComment = true;
    notifyListeners();
    try {
      addCommentState = GeneralState(requestState: RequestState.loading);
      final comment = await repo.postComment(
        CommentParamModel(bookId: bookId, content: content),
      );
      addCommentState = GeneralState(
        requestState: RequestState.success,
        data: comment,
      );
      final currentComments = generalState.data;
      final newComment = addCommentState.data;
      final list = List<CommentModel>.from([...currentComments, newComment]);
      generalState = GeneralState(
        requestState: RequestState.success,
        data: list,
      );
      if(RequestState.success == addCommentState.requestState){
        isLoadingComment = false;
      }
      notifyListeners();
    } catch (e) {
      addCommentState = GeneralState(
        requestState: RequestState.error,
        error: e.toString(),
      );
    }
    notifyListeners();
  }
}
