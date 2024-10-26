import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_05/pages/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 bool loading = false;
  Future Login() async {
      setState(() {
        loading = true;
      });
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    }catch(e){
      print('error');
    }

    if(mounted){
 setState(() {
        loading = false;
      });
    }
      
    

  }

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading(): Container(
      child: Stack(fit: StackFit.expand, children: [
        Image.asset(
          'assets/todo.png',
          fit: BoxFit.cover,
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Sign in', 
                  style: GoogleFonts.robotoCondensed(
                          fontSize: 25,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                )
              ),
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        
                      )),
                  width: 400,
                  child: TextField(
                     style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                    controller: _emailController,
                    decoration:  InputDecoration(
                      hintText: 'Email',
                     hintStyle: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                 labelStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17,
                                ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )),
                  width: 400,
                  child: TextField(
                    style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                    controller: _passwordController,
                    decoration:  InputDecoration(
                      hintText: 'Password',
                     hintStyle: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                                ),
                 labelStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17,
                                color: Colors.white),
                      border: InputBorder.none,
                  
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: Login,
                child: Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 10,
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a Member?',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: widget.showRegisterPage,
                    
                      child: const Text(' Register Here.',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))),
                ], 
              )
            ])
      ]),
    );
  }
}
