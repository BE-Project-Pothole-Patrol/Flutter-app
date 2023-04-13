class Otp {
  const Otp({
    required this.otp,
  });
  final String otp;

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      otp: json['otp'],
    );
  }
}
