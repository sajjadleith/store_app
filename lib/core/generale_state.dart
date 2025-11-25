import 'package:store/core/enums/request_state.dart';

class GeneralState<T> {
  final RequestState requestState;
  final T? data;
  final String error;
  GeneralState({
    this.requestState = RequestState.loading,
    this.error = "",
    this.data,
  });
}
