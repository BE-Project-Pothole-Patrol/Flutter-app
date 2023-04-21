class LoginModel {
  const LoginModel({
    required this.access,
    required this.refresh,
  });
  final String access;
  final String refresh;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}
