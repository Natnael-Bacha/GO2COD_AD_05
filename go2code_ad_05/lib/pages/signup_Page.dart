import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go2code_ad_05/pages/loading.dart';
import 'package:go2code_ad_05/pages/taskManager.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _NameController = TextEditingController();

  TaskManager task = TaskManager();
  bool loading = false;
  Future SignUp() async {

  setState(() {
        loading = true;
      });

    try{
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    return  loading ? Loading() : SafeArea(
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
                  'Sign up', 
                   style: GoogleFonts.robotoCondensed(
                          fontSize: 25,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                )
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
                    controller: _emailController,
                    decoration:  InputDecoration(
                      hintText: 'Email',
                     hintStyle: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.bold, 
                                color: Colors.white),
                 labelStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17),
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
                                color: Colors.white),
                 labelStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: 
                SignUp ,
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
                          'Sign Up',
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
                  const Text('Already Registerd ?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: widget.showLoginPage,
                      
                      child: const Text(' Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))),
                ],
              )
            ])
      ]),
    );
  }
}
