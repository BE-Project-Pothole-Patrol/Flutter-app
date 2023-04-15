class User {
  final int number;
  final int code;
  final String username;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    this.number = -1,
    this.code = -1,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      number: user['number'],
      code: user['code'],
      username: user['username'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      email: user['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'code': code,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
}
