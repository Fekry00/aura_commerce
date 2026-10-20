class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    String msg = json['message'] ??
        json['Message'] ??
        json['error'] ??
        'حدث خطأ غير متوقع';

    // If Laravel returned validation errors map
    if (json['errors'] is Map && (json['errors'] as Map).isNotEmpty) {
      final firstKey = (json['errors'] as Map).keys.first;
      final firstVal = (json['errors'] as Map)[firstKey];
      if (firstVal is List && firstVal.isNotEmpty) {
        msg = firstVal.first.toString();
      } else if (firstVal is String) {
        msg = firstVal;
      }
    }

    return ErrorModel(
      status: json['status'] is int
          ? json['status']
          : (json['code'] ?? json['statusCode'] ?? 500),
      errorMessage: msg,
    );
  }
}