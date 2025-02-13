import 'dart:convert';

import 'package:caller_book/Model/ContactModel.dart';
import 'package:caller_book/Page/Add_Contact_Page.dart';
import 'package:caller_book/Page/Contact_Details_Page.dart';
import 'package:caller_book/Page/Login_Page.dart';
import 'package:caller_book/Page/User_Info_Page.dart';
import 'package:caller_book/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../services/allData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal.shade50,
            leading: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoPage(),));
            }, icon: Icon(Icons.account_circle,)),
            title: Text(
                "Contact",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal
              ),
            ),
            actions: [
              IconButton(onPressed: () {
                preferences.setIsLogin(isLogin: false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              }, icon: Icon(Icons.logout))
            ],
          ),
          body: RefreshIndicator(
            color: Colors.teal,
            onRefresh: () async {
              setState(() {});
            },
            child: FutureBuilder(
                future: getContact(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    );
                  }else if(!snapshot.hasData || snapshot.data!.data!.isEmpty){
                    return Center(
                      child: Text("No Contact Found",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 25,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold
                      ),),
                    );
                  }else if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Icon(Icons.delete),
                            confirmDismiss: (direction) {
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
                                  title: Text("Delete Contact?"),
                                  content: Text("Are you sure you want to delete this contact?"),
                                  actions: [
            
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("No,Cancel",style: TextStyle(color: Colors.green),)),
            
                                    TextButton(onPressed: () async {
            
                                      var url=Uri.parse("https://api-9aiv.onrender.com/ContactDelete/${snapshot.data!.data![index].id}");
                                      print("object=$url");
                                      var response=await http.get(url);
                                      print("response = ${response.body}");
                                      var data=jsonDecode(response.body);
                                      if(data['status']=="Success"){
                                        allData.showSuccess(msg: "Contact Delete Successfully.");
                                      }else{
                                        allData.showError(msg: "Contact Not Delete. Please Try Again.");
                                      }
                                      Navigator.pop(context);
                                      setState(() {});
            
                                    }, child: Text("Yes,Delete",style: TextStyle(color: Colors.red),))
            
                                  ],
                                ),
                              );
                            },
                            key: Key("value"),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetailsPage(data: snapshot.data!.data![index]),));
                              },
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              tileColor: Colors.teal.shade100,
                              leading: CircleAvatar(
                                child: Icon(
                                    Icons.account_circle_outlined,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                              title: Text("${snapshot.data!.data![index].name}"),
                              subtitle: Text("${snapshot.data!.data![index].contactNo}"),
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: Text("Something Went Wrong",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 25,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold
                      ),),
                    );
                  }
                },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal.shade200,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(),));
            },
          ),
        ),
      ),
    );
  }

  Future<ContactModel> getContact() async {
    var url=Uri.parse("https://api-9aiv.onrender.com/ContactView");
    var response=await http.get(url);
    print("response=${response.body}");
    Map tempData=jsonDecode(response.body);
    ContactModel contactModel=ContactModel.fromJson(tempData);
    return contactModel;
  }
}
