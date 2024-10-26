import 'package:flutter/material.dart';
import 'package:go2code_ad_05/pages/login_page.dart';
import 'package:go2code_ad_05/pages/signup_Page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLogInPage = true;
   
   void toggleScreen(){
     setState(() {
       showLogInPage = !showLogInPage;
     });
   }

  @override
  Widget build(BuildContext context) {
    if(showLogInPage){
           return LoginPage(showRegisterPage: toggleScreen);
    }else{
           return SignupPage(showLoginPage: toggleScreen);
    }
  }
}