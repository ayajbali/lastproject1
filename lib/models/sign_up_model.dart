class SignUpBody {
  String username;
  String phone;
  String password;
  String email;

  SignUpBody({
    required this.username,
    required this.email,
    required this.password,
    required this.phone
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "phone": phone,
      "email": email,
      "password": password
    };
  }
}
