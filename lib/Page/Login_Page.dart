import 'dart:convert';

import 'package:caller_book/Model/LoginModel.dart';
import 'package:caller_book/Model/UserInfoModel.dart';
import 'package:caller_book/Page/Home_Page.dart';
import 'package:caller_book/services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../services/allData.dart';
import 'Register_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  bool isShowPass=true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal.shade50,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200,),
                Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
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
                InkWell(
                  onTap: login,
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
                      "Login",
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
                      "Not a member? ",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                      },
                      child: Text(
                        "Signup now",
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
  Future<void> login() async {
    try{
      if(email.text!="" && password.text!=""){
        var url=Uri.parse("https://api-9aiv.onrender.com/ContactLogin");
        LoginModel loginModel=LoginModel(email.text, password.text);
        var response=await http.post(url,body: loginModel.toJson());
        print("Response=${response.body}");
        var data=jsonDecode(response.body);
        if(data["status"]=="Success"){
          preferences.setIsLogin(isLogin: true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
          allData.showSuccess(msg: "Login Successfully.");
        }else{
          allData.showError(msg: "${data['status']}");
        }
      }else{
        allData.showError(msg: "Please Enter The Required Field.");
      }
    }catch(e){
      allData.showError(msg: "Something Went Wrong. Please Try Again.");
    }
  }
}
