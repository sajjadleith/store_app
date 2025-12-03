import 'package:equatable/equatable.dart';
import 'package:store/core/enums/request_state.dart';

class GeneralState<T> extends Equatable {
  final RequestState requestState;
  final T? data;
  final String error;

  const GeneralState({
    this.requestState = RequestState.loading,
    this.error = "",
    this.data,
  });

  GeneralState<T> copyWith({
    RequestState? requestState,
    T? data,
    String? error,
  }) {
    return GeneralState<T>(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [requestState, data, error];
}
