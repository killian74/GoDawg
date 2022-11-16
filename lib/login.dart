import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _emailController;
  late TextEditingController _pwd1Controller;
  late TextEditingController _pwd2Controller;

  bool showPwdTextField = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwd1Controller = TextEditingController();
    _pwd2Controller = TextEditingController();

  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwd1Controller.dispose();
    _pwd2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text("Truman State University", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text("GoDawg", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 60.0),),
                    const SizedBox(height: 20.0,),
                    const Text("Please enter your email address", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    const SizedBox(height: 20.0,),
                    simpleTextField(_emailController, false, "Email address"),
                    SizedBox(height: showPwdTextField? 10.0:0,),
                    showPwdTextField? simpleTextField(_pwd1Controller, true, "Password") : const SizedBox.shrink(),
                    SizedBox(height: showPwdTextField? 10.0:0,),
                    showPwdTextField? simpleTextField(_pwd2Controller, true, "Password confirmation") : const SizedBox.shrink(),

                  ],
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      if (showPwdTextField) {
                        _signUpWithPassword().then((value) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
                        });
                      }else{
                        setState(() {
                          showPwdTextField = true;
                        });
                      }
                    },
                    child: Text(showPwdTextField? "Login" : 'Continue', style: const TextStyle(fontSize: 20.0, color: Colors.black),),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  TextField simpleTextField(TextEditingController controller, bool isPwd, String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      obscureText: isPwd,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white),

            fillColor: Colors.deepPurple,
            filled: true,
            prefixIcon: Icon(isPwd? CupertinoIcons.padlock : Icons.email_outlined, color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0
                )
            )
        )
    );
  }

  Future<User?> _signUpWithPassword() async {

    User? user;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _pwd1Controller.text.trim(),
      );

      user = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}
