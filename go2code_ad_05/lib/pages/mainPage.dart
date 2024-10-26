import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_05/pages/auth.dart';
import 'package:go2code_ad_05/pages/home.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) { 
          if(snapshot.hasData){
            return const Home();
          }else{
            return const AuthPage();
          }
         },),
      ),
    );
  }
}