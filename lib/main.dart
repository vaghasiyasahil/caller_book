import 'package:caller_book/Page/Home_Page.dart';
import 'package:caller_book/Page/Login_Page.dart';
import 'package:caller_book/Page/Register_Page.dart';
import 'package:caller_book/services/preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.intMemory();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: preferences.getIsLogin()?HomePage():LoginPage(),
    )
  );
}
