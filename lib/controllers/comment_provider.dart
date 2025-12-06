import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/app_constant.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/model/comment_model.dart';
import 'package:store/model/comment_param_model.dart';
import 'package:store/repo/api_repo.dart';
import 'package:http/http.dart' as http;

class CommentProvider extends ChangeNotifier {
  final ApiRepo repo = ApiRepo();
  GeneralState generalState = GeneralState();
  GeneralState addCommentState = GeneralState();
  GeneralState updateCommentUiState = GeneralState();

  void fetchData(String id) async {
    try {
      generalState = GeneralState(requestState: RequestState.loading);

      final List<CommentModel> comments = await repo.getCommentDatas(id);

      generalState = GeneralState(requestState: RequestState.success, data: comments);
    } catch (e) {
      generalState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }

  bool isLoadingComment = false;
  void addComment(String content, String bookId) async {
    isLoadingComment = true;
    notifyListeners();
    try {
      addCommentState = GeneralState(requestState: RequestState.loading);
      final comment = await repo.postComment(CommentParamModel(bookId: bookId, content: content));
      addCommentState = GeneralState(requestState: RequestState.success, data: comment);
      final currentComments = generalState.data;
      final newComment = addCommentState.data;
      final list = List<CommentModel>.from([...currentComments, newComment]);
      generalState = GeneralState(requestState: RequestState.success, data: list);
      if (RequestState.success == addCommentState.requestState) {
        isLoadingComment = false;
      }
      notifyListeners();
    } catch (e) {
      addCommentState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }

  Future<void> updateComment({required String commentId, required String newContent}) async {
    try {
      updateCommentUiState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final updatedComment = await repo.updateComment(commentId, newContent);

      final List<CommentModel> current = generalState.data;
      final index = current.indexWhere((c) => c.id == commentId);

      if (index != -1) {
        current[index] = updatedComment;
      }

      generalState = GeneralState(requestState: RequestState.success, data: current);

      updateCommentUiState = GeneralState(requestState: RequestState.success, data: updatedComment);
    } catch (e) {
      updateCommentUiState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }

  GeneralState deleteCommentState = GeneralState(requestState: RequestState.empty);

  Future<void> deleteComment(String commentId) async {
    try {
      deleteCommentState = GeneralState(requestState: RequestState.loading);
      notifyListeners();

      final success = await repo.deleteComment(commentId);

      if (success) {
        final List<CommentModel> current = generalState.data;
        current.removeWhere((c) => c.id == commentId);

        generalState = GeneralState(requestState: RequestState.success, data: current);

        deleteCommentState = GeneralState(requestState: RequestState.success, data: true);
      } else {
        deleteCommentState = GeneralState(
          requestState: RequestState.error,
          error: "Failed to delete comment",
        );
      }
    } catch (e) {
      deleteCommentState = GeneralState(requestState: RequestState.error, error: e.toString());
    }
    notifyListeners();
  }
}
