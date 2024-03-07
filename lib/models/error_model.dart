import 'dart:convert';

class ErrorModel {
  final String error;
  final String message;

  ErrorModel({
    required this.error,
    required this.message,
  });

  ErrorModel copyWith({
    String? error,
    String? message,
  }) =>
      ErrorModel(
        error: error ?? this.error,
        message: message ?? this.message,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'error': error,
        'message': message,
      };

  factory ErrorModel.fromMap(Map<String, dynamic> map) => ErrorModel(
        error: map['error'] as String,
        message: map['message'] as String,
      );

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ErrorModel(error: $error, message: $message)';

  @override
  bool operator ==(covariant ErrorModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.error == error && other.message == message;
  }

  @override
  int get hashCode => error.hashCode ^ message.hashCode;
}
