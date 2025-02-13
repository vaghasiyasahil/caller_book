import 'dart:convert';

import 'package:caller_book/Model/RegisterModel.dart';
import 'package:caller_book/Page/Home_Page.dart';
import 'package:caller_book/Page/Login_Page.dart';
import 'package:caller_book/services/allData.dart';
import 'package:caller_book/services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  bool isShowPass=true;
  String gender="male";
  List hobby=["Coding","Singing"];
  List hobbyTemp=[false,false];
  String cityName="Select City";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal.shade50,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Center(
                    child: Text(
                        "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      label: Text("Name"),
                      labelStyle: TextStyle(
                        color: Colors.teal
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: email,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      labelStyle: TextStyle(
                        color: Colors.teal
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: isShowPass,
                    controller: password,
                    cursorColor: Colors.teal,
                    onTap: () {
                      setState(() {
                        isShowPass=!isShowPass;
                      });
                    },
                    decoration: InputDecoration(
                      suffix: Icon(isShowPass?CupertinoIcons.eye_slash:CupertinoIcons.eye),
                      label: Text("Password"),
                      labelStyle: TextStyle(
                        color: Colors.teal
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                          "Gender:",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RadioListTile(
                          activeColor: Colors.teal,
                          value: "male",
                          groupValue: gender,
                          title: Text("Male",style: TextStyle(
                              fontSize: 18
                          ),),
                          onChanged: (value) {
                            setState(() {
                              gender=value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RadioListTile(
                          activeColor: Colors.teal,
                          value: "female",
                          groupValue: gender,
                          title: Text("Female",style: TextStyle(
                              fontSize: 18
                          ),),
                          onChanged: (value) {
                            setState(() {
                              gender=value.toString();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                          "Hobby:",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Flexible(
                        child: CheckboxListTile(
                          activeColor: Colors.teal,
                          title: Text(hobby[0],style: TextStyle(fontSize: 18),),
                          value: hobbyTemp[0],
                          onChanged: (value) {
                            setState(() {
                              hobbyTemp[0]=!hobbyTemp[0];
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: CheckboxListTile(
                          activeColor: Colors.teal,
                          title: Text(hobby[1],style: TextStyle(fontSize: 18),),
                          value: hobbyTemp[1],
                          onChanged: (value) {
                            setState(() {
                              hobbyTemp[1]=!hobbyTemp[1];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                          "Hobby:",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: DropdownButton(
                            value: cityName,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              ),
                              items: [
                                DropdownMenuItem(enabled: false,child: Text("Select City"),value: "Select City",),
                                DropdownMenuItem(child: Text("Surat"),value: "Surat",),
                                DropdownMenuItem(child: Text("Ahmedabad"),value: "Ahmedabad",),
                                DropdownMenuItem(child: Text("Rajkot"),value: "Rajkot",),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  cityName=value.toString();
                                });
                              },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: register,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                        "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> register() async {
    try{
      if(name.text!="" && email.text!="" && password.text!="" && cityName!="Select City"){
        var url=Uri.parse("https://api-9aiv.onrender.com/Contact");
        String hobbyJoin="";
        for(int i=0;i<hobbyTemp.length;i++){
          if(hobbyTemp[i]){
            hobbyJoin=hobbyJoin+"${hobby[i]},";
          }
        }
        hobbyJoin=hobbyJoin.substring(0,hobbyJoin.length-1);
        RegisterModel registerModel=RegisterModel(
            name.text,
            email.text,
            password.text,
            gender,
            hobbyJoin,
            cityName
        );
        var response=await http.post(url,body: registerModel.toJson());
        print("object=${response.body}");
        var data=jsonDecode(response.body);

        if(data['status']=="Success"){
          allData.showSuccess(msg: "Registered Successfully, Please Login.");
          preferences.setIsLogin(isLogin: true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
        }else if(data['status']=="Error"){
          allData.showError(msg: "Email Already Exists.");
        }else{
          allData.showError(msg: "Something Went Wrong. Please Try Again.");
        }
      }else{
        allData.showError(msg: "Please Enter The Required Field.");
      }
    }catch(e){
      allData.showError(msg: "Something Went Wrong. Please Try Again.");
    }
  }
}