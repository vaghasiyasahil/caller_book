/// email : "demo@gmail.com"
/// password : "demo@123"

class LoginModel {
  String? email;
  String? password;

  LoginModel(this.email, this.password);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
