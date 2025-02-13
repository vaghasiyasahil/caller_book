import 'dart:convert';
/// status : "Success"
/// data : [{"_id":"67a6103fe7ef55f947863750","name":"aaa","email":"aaa","contact_no":"aaa","user_id":"0","__v":0},{"_id":"67a610dbe7ef55f947863753","name":"gautamm","email":"gautamm@gmail.com","contact_no":"123","user_id":"0","__v":0},{"_id":"67a610f1e7ef55f947863755","name":"niral","email":"niral12@gmail.com","contact_no":"123456","user_id":"0","__v":0},{"_id":"67a61112e7ef55f947863758","name":"sahil","email":"sahilv152@gmail.com","contact_no":"123456789","user_id":"0","__v":0},{"_id":"67a61133e7ef55f94786375a","name":"atul","email":"atuldegada50@gmail.com","contact_no":"987654321","user_id":"0","__v":0},{"_id":"67a61230e7ef55f94786375f","name":"atul","email":"atuldegada550@gmail.com","contact_no":"987654321","user_id":"0","__v":0},{"_id":"67a61253e7ef55f947863763","name":"atul","email":"atuldegada51@gmail.com","contact_no":"987654321","user_id":"0","__v":0}]

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));
String contactModelToJson(ContactModel data) => json.encode(data.toJson());
class ContactModel {
  ContactModel({
      String? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  ContactModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  List<Data>? _data;

  String? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "67a6103fe7ef55f947863750"
/// name : "aaa"
/// email : "aaa"
/// contact_no : "aaa"
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