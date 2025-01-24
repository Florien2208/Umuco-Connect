class AuthResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? errors;

  AuthResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
      errors: json['errors'],
    );
  }
}
