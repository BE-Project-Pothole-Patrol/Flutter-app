class Verified {
  const Verified({
    required this.success,
  });
  final String success;

  factory Verified.fromJson(Map<String, dynamic> json) {
    return Verified(
      success: json['message'],
    );
  }
}
