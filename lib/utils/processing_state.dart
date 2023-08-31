import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_state.freezed.dart';

@freezed
class ProcessingState<T> with _$ProcessingState<T> {
  const factory ProcessingState.loading() = _Loading;
  const factory ProcessingState.failed() = _Failed;
  const factory ProcessingState.success(T data) = _Loaded;
}
