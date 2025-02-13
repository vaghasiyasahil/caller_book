import 'dart:convert';
import 'package:caller_book/Model/UserInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Home_Page.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  UserInfoModel userInfoModel=UserInfoModel();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      },
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.teal.shade50,
            appBar: AppBar(
              backgroundColor: Colors.teal.shade50,
              title: Text(
                  "${userInfoModel.data==null?"":userInfoModel.data!.name}"
              ),
            ),
            body: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                      backgroundColor: Colors.teal.shade100,
                    ),
                  );
                }else if(snapshot.hasData){
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "${userInfoModel.data!.name}",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "${userInfoModel.data!.email}",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hobby",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "${userInfoModel.data!.hobby}",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "${userInfoModel.data!.gender}",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "${userInfoModel.data!.city}",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }else{
                  return Center(
                    child: Text("Something Went Wrong",style: TextStyle(fontSize: 20),),
                  );
                }

              },
            )
          )
      ),
    );
  }
  Future<UserInfoModel?> getData() async {
    var url=Uri.parse("https://api-9aiv.onrender.com/ContactAccount");
    var response=await http.get(url);
    var data=jsonDecode(response.body);
    if(data["status"]=="Success"){
      userInfoModel = UserInfoModel.fromJson(data);
      print("userInfoModel=$userInfoModel");
    }else{
      return null;
    }
    return userInfoModel;
  }
}
