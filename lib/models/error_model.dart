class ErrorRes {
  const ErrorRes({
    required this.error,
  });
  final String error;

  factory ErrorRes.fromJson(Map<String, dynamic> json) {
    return ErrorRes(
      error: json['error'],
    );
  }
}
