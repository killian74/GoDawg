import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/menu/camera_page_menu.dart';
import 'package:go_dawg/menu/contact_page_menu.dart';
import 'package:go_dawg/menu/group_study_page_menu.dart';
import 'package:go_dawg/menu/subjects_page_menu.dart';
import 'package:go_dawg/models/appUser.dart';

class MenuHandler extends StatefulWidget {
  final String uid;

  const MenuHandler({Key? key, required this.uid}) : super(key: key);

  @override
  State<MenuHandler> createState() => _MenuHandlerState();
}

class _MenuHandlerState extends State<MenuHandler> {

  int index = 0;

  late AppUser user;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(widget.uid).snapshots().listen((event) {
      setState(() {
        user = AppUser(event);
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    List<String> menuPageTitles = ["Subjects", "Group Study", "Contact"];
    List<Widget> menuPages = const [
      SubjectsPage(),
      GroupStudyPageMenu(),
      ContactPage(),
      //CameraPage(),
    ];

    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(CupertinoIcons.profile_circled, size: 60.0, color: Colors.white,),
                          SizedBox(width: 5.0,),
                          Text("Killian Pinier", style: TextStyle(color: Colors.white, fontSize: 20.0),)
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Text(user.email, style: const TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),

              drawerOptions(CupertinoIcons.info, "About", () {}),
              drawerOptions(Icons.logout, "Sign Out", () => FirebaseAuth.instance.signOut()),
            ],
          )
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
      body: menuPages[index],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        //unselectedLabelStyle: TextStyle(color: Colors.grey),
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), label: "Subjects"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.group), label: "Group Study"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: "Contact"),
          //BottomNavigationBarItem(icon: Icon(CupertinoIcons.camera), label: "Camera"),
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

  Widget drawerOptions(IconData icon, String text, Function function) {
    return InkWell(
      onTap: () => function,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 35.0,),
          ),
          Text(text, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold
          ),)
        ],
      ),
    );
  }

}
