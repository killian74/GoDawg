import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/menu/group_study/materials_page.dart';
import 'package:go_dawg/menu/group_study/peer_page.dart';
import 'package:go_dawg/menu/group_study/tutoring_page.dart';
import 'package:go_dawg/models/pair.dart';

class GroupStudyPage extends StatefulWidget {
  final Pair course;
  final String fullName;
  const GroupStudyPage({Key? key, required this.course, required this.fullName}) : super(key: key);

  @override
  State<GroupStudyPage> createState() => _GroupStudyPageState();
}

class _GroupStudyPageState extends State<GroupStudyPage> with TickerProviderStateMixin{

  late TabController _tabController;

  final objectController = TextEditingController();
  final messageController = TextEditingController();

  int tabBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    objectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.course.name),
          bottom: TabBar(
              onTap: (int i) {
                setState(() {
                  tabBarIndex = i;
                });
              },
              controller: _tabController,
              tabs: const [
                Tab(text: "Material"),
                Tab(text: "Tutoring"),
                Tab(text: "Peer"),
              ]
          ),
        ),

        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MaterialsPage(course: widget.course,),
            TutoringPage(course: widget.course,),
            PeerPage(course: widget.course, fullName: widget.fullName,)
          ],
        ),

        floatingActionButton: _bottomButtons()
    );
  }

  Widget _bottomButtons() {
    return tabBarIndex == 2? FloatingActionButton(
        onPressed: () => _showMyDialog(),
        child: const Icon(
          Icons.message,
          size: 20.0,
        )) : const SizedBox.shrink();
  }

  Future<void> _showMyDialog() async {
    if(Platform.isIOS) {
      return showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Add an announcement'),
              content: Column(
                children: [
                  const SizedBox(height: 5.0,),
                  iosTextField(objectController, "Object", Icons.emoji_objects),
                  const SizedBox(height: 5.0,),
                  iosTextField(messageController, "Message", Icons.message)
                ],
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    addAnnouncementToFirebase();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          }
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            title: const Text('Add a new announcement'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  androidTextField(objectController, "Object", Icons.emoji_objects),
                  const SizedBox(height: 5.0,),
                  androidTextField(messageController, "Message", Icons.message)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  addAnnouncementToFirebase();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> addAnnouncementToFirebase() async{
    await FirebaseFirestore.instance.collection("groupStudy").doc(widget.course.id).collection("peer").doc().set({
      "object": objectController.text,
      "message" : messageController.text,
      "userName" : widget.fullName,
    });

    setState(() {
      objectController.clear();
      messageController.clear();
    });
  }

  TextField androidTextField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.deepPurple,
          filled: true,
          prefixIcon: Icon(icon, color: Colors.white),
          border: const OutlineInputBorder( //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none
          ),
        )
    );
  }

  CupertinoTextField iosTextField(TextEditingController controller, String hint, IconData icon) {
    return CupertinoTextField(
      placeholder: hint,

      controller: controller,
    );
  }
}
