import 'package:shared_preferences/shared_preferences.dart';

class preferences{
  static late SharedPreferences prefs;

  static intMemory() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setIsLogin({required bool isLogin}){
    prefs.setBool("isLogin", isLogin);
  }
  static bool getIsLogin(){
    return prefs.getBool("isLogin")??false;
  }

}