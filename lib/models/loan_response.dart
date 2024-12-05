class LoanResponse {
  bool isError;
  String message;

  LoanResponse({
    required this.isError,
    required this.message,
  });

  factory LoanResponse.fromJson(Map<String, dynamic> json) {
    return LoanResponse(
      isError: json['isError'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isError': isError,
      'message': message,
    };
  }
}
