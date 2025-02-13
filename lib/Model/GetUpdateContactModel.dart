import 'dart:convert';
/// status : "Success"
/// data : {"_id":"67a61133e7ef55f94786375a","name":"bbbccc","email":"bbbccc@gmail.com","contact_no":"98765432","user_id":"0","__v":0}

GetUpdateContactModel getUpdateContactModelFromJson(String str) => GetUpdateContactModel.fromJson(json.decode(str));
String getUpdateContactModelToJson(GetUpdateContactModel data) => json.encode(data.toJson());
class GetUpdateContactModel {
  GetUpdateContactModel({
      String? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  GetUpdateContactModel.fromJson(dynamic json) {
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

/// _id : "67a61133e7ef55f94786375a"
/// name : "bbbccc"
/// email : "bbbccc@gmail.com"
/// contact_no : "98765432"
/// user_id : "0"
/// __v : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? email, 
      String? contactNo, 
      String? userId, 
      int? v,}){
    _id = id;
    _name = name;
    _email = email;
    _contactNo = contactNo;
    _userId = userId;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _userId = json['user_id'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _contactNo;
  String? _userId;
  int? _v;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get userId => _userId;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['user_id'] = _userId;
    map['__v'] = _v;
    return map;
  }

}