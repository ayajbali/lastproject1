class SignUpBody{
  String usernamename;
  String phone;
  String password;
  String email;

  SignUpBody({
    required this.usernamename,
    required this.email,
    required this.password,
    required this.phone
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>(); 
    data["f_username"]=this.usernamename;
    data["phone"]=this.phone;
    data["email"]=this.email;
    data["password"]=this.password;
    return data;
  }
}