class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status'] ?? json['code'] ?? json['statusCode'] ?? 500,
      errorMessage: json['message'] ??
          json['Message'] ??
          json['error'] ??
          'حدث خطأ غير متوقع',
    );
  }
}