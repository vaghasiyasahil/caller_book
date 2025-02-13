import 'dart:convert';
/// name : "admin"
/// email : "demo@gmail.com"
/// contact_no : "123456798"

class SaveContactModel {
  String? name;
  String? email;
  String? contactNo;

  SaveContactModel(this.name, this.email, this.contactNo);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['contact_no'] = contactNo;
    return map;
  }

}
