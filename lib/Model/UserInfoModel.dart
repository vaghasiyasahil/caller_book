import 'dart:convert';
/// status : "Success"
/// data : {"_id":"67a5ff00c90dfec51f9b6f87","name":"aaa","email":"aaa","password":"aaa","gender":"female","hobby":"CodingSingin","city":"Rajkot","__v":0}

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));
String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());
class UserInfoModel {
  UserInfoModel({
      String? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  UserInfoModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Data? _data;

  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// _id : "67a5ff00c90dfec51f9b6f87"
/// name : "aaa"
/// email : "aaa"
/// password : "aaa"
/// gender : "female"
/// hobby : "CodingSingin"
/// city : "Rajkot"
/// __v : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? email, 
      String? password, 
      String? gender, 
      String? hobby, 
      String? city, 
      int? v,}){
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _gender = gender;
    _hobby = hobby;
    _city = city;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _gender = json['gender'];
    _hobby = json['hobby'];
    _city = json['city'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _gender;
  String? _hobby;
  String? _city;
  int? _v;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get gender => _gender;
  String? get hobby => _hobby;
  String? get city => _city;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['gender'] = _gender;
    map['hobby'] = _hobby;
    map['city'] = _city;
    map['__v'] = _v;
    return map;
  }

}