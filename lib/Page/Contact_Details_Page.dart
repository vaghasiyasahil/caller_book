import 'dart:convert';

import 'package:caller_book/Page/Add_Contact_Page.dart';
import 'package:caller_book/Page/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/ContactModel.dart';
import '../services/allData.dart';

class ContactDetailsPage extends StatefulWidget {
  Data data;
  ContactDetailsPage({required this.data,super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
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
              "${widget.data.name}"
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
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
                          var url=Uri.parse("https://api-9aiv.onrender.com/ContactDelete/${widget.data.id}");
                          var response=await http.get(url);
                          var data=jsonDecode(response.body);
                          if(data['status']=="Success"){
                            allData.showSuccess(msg: "Contact Delete Successfully.");
                          }else{
                            allData.showError(msg: "Contact Not Delete. Please Try Again.");
                          }
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                          setState(() {});
                        }, child: Text("Yes,Delete",style: TextStyle(color: Colors.red),))

                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete)
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(data: widget.data,),));
                  },
                  icon: Icon(Icons.edit)
              ),
            ],
          ),
          body: Column(
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
                        "${widget.data.name}",
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
                        "Number",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "${widget.data.contactNo}",
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
                        "${widget.data.email}",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
