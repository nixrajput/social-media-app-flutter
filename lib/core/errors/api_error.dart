class ApiError implements Exception {
  const ApiError({
    required this.status,
    required this.code,
    required this.message,
    this.requestId,
  });

  final int status;
  final String code;
  final String message;
  final String? requestId;

  factory ApiError.fromResponse(int status, dynamic body) {
    if (body is Map && body['error'] is Map) {
      final err = body['error'] as Map;
      return ApiError(
        status: status,
        code: (err['code'] as String?) ?? 'INTERNAL',
        message: (err['message'] as String?) ?? 'Something went wrong',
        requestId: err['requestId'] as String?,
      );
    }
    return ApiError(
      status: status,
      code: 'INTERNAL',
      message: 'Something went wrong',
    );
  }

  bool get isNetwork => status == 0;

  @override
  String toString() => 'ApiError($status $code: $message)';
}
