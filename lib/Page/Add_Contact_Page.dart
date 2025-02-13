import 'dart:convert';

import 'package:caller_book/Model/SaveContactModel.dart';
import 'package:caller_book/Page/Contact_Details_Page.dart';
import 'package:caller_book/Page/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/ContactModel.dart';
import '../services/allData.dart';

class AddContactPage extends StatefulWidget {
  Data? data;
  AddContactPage({this.data,super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController number=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data!=null){
      name.text=widget.data!.name!;
      number.text=widget.data!.contactNo!;
      email.text=widget.data!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(widget.data==null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetailsPage(data: widget.data!),));
        }
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
                        "Add Contact",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
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
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
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
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: number,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        label: Text("Number"),
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
                SizedBox(height: 30,),
                InkWell(
                  onTap: save,
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
                      "Save",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> save() async {
    try{
      if(widget.data==null){
        if(name.text!="" && email.text!="" && number.text!=""){
          var url=Uri.parse("https://api-9aiv.onrender.com/ContactAdd");
          SaveContactModel saveContactModel=SaveContactModel(name.text, email.text, number.text);
          var response=await http.post(url,body: saveContactModel.toJson());
          print("Response=${response.body}");
          var data=jsonDecode(response.body);
          if(data['status']=="Success"){
            allData.showSuccess(msg: "Contact Added Successfully.");
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
          }else if(data['status']=="Error"){
            allData.showError(msg: "Email Already Exit.");
          }else{
            allData.showError(msg: "Something Went Wrong. Please Try Again.");
          }
        }else{
          allData.showError(msg: "Please Enter The Required Field.");
        }
      }else{
        if(name.text!="" && email.text!="" && number.text!=""){
          var url=Uri.parse("https://api-9aiv.onrender.com/ContactUpdate/${widget.data!.id}");
          SaveContactModel saveContactModel=SaveContactModel(name.text, email.text, number.text);
          var response=await http.post(url,body: saveContactModel.toJson());
          var tempData=jsonDecode(response.body);

          if(tempData["status"]=="Success"){

            var url=Uri.parse("https://api-9aiv.onrender.com/ContactUpdate/${widget.data!.id}");
            var response=await http.get(url);
            Map tempData=jsonDecode(response.body);
            Data nData=Data(
              id: tempData['data']['_id'],
              name: tempData['data']['name'],
              email: tempData['data']['email'],
              contactNo: tempData['data']['contact_no'],
              userId: tempData['data']['user_id'],
              v: tempData['data']['__v'],
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetailsPage(data: nData),));
            
            allData.showSuccess(msg: "Contact Update Successfully.");
          }else{
            allData.showError(msg: "Contact Not Update. Please Try Again.");
          }

        }else{
          allData.showError(msg: "Please Enter The Required Field.");
        }
      }
    }catch(e){
      print("Error=$e");
      allData.showError(msg: "Something Went Wrong. Please Try Again.");
    }
  }
}
