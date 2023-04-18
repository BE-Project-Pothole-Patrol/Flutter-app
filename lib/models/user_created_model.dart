class UserCreatedModel {
  const UserCreatedModel({
    required this.success,
  });
  final String success;

  factory UserCreatedModel.fromJson(Map<String, dynamic> json) {
    return UserCreatedModel(
      success: json['success'],
    );
  }
}
