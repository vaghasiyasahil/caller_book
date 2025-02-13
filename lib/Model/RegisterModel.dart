/// name : "admin"
/// email : "demo@gmail.com"
/// password : "demo@123"
/// gender : "male"
/// hobby : "playing"
/// city : "surat"

class RegisterModel {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? hobby;
  String? city;

  RegisterModel(this.name, this.email, this.password, this.gender, this.hobby, this.city);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['gender'] = gender;
    map['hobby'] = hobby;
    map['city'] = city;
    return map;
  }
}
