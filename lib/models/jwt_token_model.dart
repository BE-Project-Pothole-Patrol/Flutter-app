class JwtTokenModel {
  const JwtTokenModel({
    required this.access,
    required this.refresh,
  });
  final String access;
  final String refresh;

  factory JwtTokenModel.fromJson(Map<String, dynamic> json) {
    return JwtTokenModel(
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}
