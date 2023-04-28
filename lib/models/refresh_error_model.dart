class RefreshErrorModel {
  const RefreshErrorModel({
    required this.detail,
    required this.code,
  });
  final String detail;
  final String code;

  factory RefreshErrorModel.fromJson(Map<String, dynamic> json) {
    return RefreshErrorModel(
      detail: json['detail'],
      code: json['code'],
    );
  }
}
