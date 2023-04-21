class LoginErrorModel {
  const LoginErrorModel({
    required this.detail,
  });
  final String detail;

  factory LoginErrorModel.fromJson(Map<String, dynamic> json) {
    return LoginErrorModel(
      detail: json['detail'],
    );
  }
}
