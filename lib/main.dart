import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_dawg/login/login.dart';
import 'package:go_dawg/menu/menu_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              checkUser(snapshot.data!);

              User user = snapshot.data!;

              return MenuHandler(uid: snapshot.data!.uid);
            }

            return const LoginPage();
          }
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> checkUser(User user) async {
    var query = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

    if(!query.exists) {
      Map<String, dynamic> map = {
        "email" : user.email,
        "uid" : user.uid,
        "fullName" : "",
        "majors" : [],
        "minors" : [],
        "phone" : 0,
        "studentId" : 0,
        "status" : ""
      };

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(map);
    }

  }
}





