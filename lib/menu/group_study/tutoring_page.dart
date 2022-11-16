import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/models/pair.dart';

class TutoringPage extends StatelessWidget {
  final Pair course;
  const TutoringPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("groupStudy").doc(course.id).collection("tutoring").get(),
          builder: (context, snapshot) {
            List<Tutoring> tutoring = [];
            if (snapshot.connectionState == ConnectionState.done) {
              for(var element in snapshot.data!.docs) {
                Map<String, dynamic> data = element.data();
                tutoring.add(Tutoring(data));
              }

              return ListView.builder(
                  itemCount: tutoring.length,
                  itemBuilder: (context, index) {
                    return tutoringTile(tutoring[index]);
                  }
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }

          }
      ),
    );
  }

  Widget tutoringTile(Tutoring tutoring) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tutoring.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Icon(CupertinoIcons.location_solid, color: Colors.grey, size: 20.0,),
                Text(tutoring.location, style: TextStyle(color: Colors.grey),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Text("Monday : 10:30am - 11:20am"),
                  Text("Tuesday : 10:30am - 11:20am"),
                  Text("Friday : 10:30am - 11:20am"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Tutoring {
  late String location;
  late String name;
  late String uid;
  late Map<String, dynamic> schedule;

  Tutoring(Map<String, dynamic> map) {
    location = map["location"];
    name = map["name"];
    uid = map["uid"];
    schedule = map["schedule"];
  }
}
