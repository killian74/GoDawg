import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/menu/camera_page.dart';
import 'package:go_dawg/menu/contact_page.dart';
import 'package:go_dawg/menu/group_study_page.dart';
import 'package:go_dawg/menu/subjects_page.dart';
import 'package:go_dawg/models/appUser.dart';

class MenuHandler extends StatefulWidget {
  final String uid;

  const MenuHandler({Key? key, required this.uid}) : super(key: key);

  @override
  State<MenuHandler> createState() => _MenuHandlerState();
}

class _MenuHandlerState extends State<MenuHandler> {

  int index = 0;

  @override
  Widget build(BuildContext context) {

    List<String> menuPageTitles = ["Subjects", "Group Study", "Camera", "Contact"];
    List<Widget> menuPages = const [
      SubjectsPage(),
      GroupStudyPage(),
      ContactPage(),
      CameraPage(),
    ];

    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("KP"),

                    ),
                    SizedBox(width: 5.0,),
                    Text("Killian Pinier", style: TextStyle(color: Colors.white, fontSize: 20.0),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      appBar: AppBar(
        //leading: IconButton(
        //    onPressed: () {},
        //    icon: const Icon(Icons.menu)
        //),
        elevation: 0.0,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(menuPageTitles[index], style: const TextStyle(fontSize: 24.0),),
        actions: [
          index == 0? IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(CupertinoIcons.star, color: Colors.yellow,)
          ) : const SizedBox.shrink()
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(widget.uid).get(),


          builder: (context, snapshot) {
          AppUser user;

            if(snapshot.connectionState == ConnectionState.done) {
               user = AppUser(snapshot.data);
               return menuPages[index];
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        //unselectedLabelStyle: TextStyle(color: Colors.grey),
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), label: "Subjects"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.group), label: "Group Study"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: "Contact"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.camera), label: "Camera"),
        ],
        currentIndex: index,
        selectedItemColor: Colors.deepPurple,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
      ),

    );
  }

}
