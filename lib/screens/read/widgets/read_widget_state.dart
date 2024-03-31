sealed class ReadWidgetState {}

final class ReadWidgetStateInitial extends ReadWidgetState {}

final class ReadWidgetStateError extends ReadWidgetState {
  final String error;

  ReadWidgetStateError({
    required this.error,
  });
}

final class ReadWidgetStateSuccess extends ReadWidgetState {}
