import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/models/announcement.dart';
import 'package:go_dawg/models/pair.dart';

class PeerPage extends StatelessWidget {
  final Pair course;
  final String fullName;
  const PeerPage({Key? key, required this.course, required this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("groupStudy").doc(course.id).collection("peer").get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {

              List<Announcement> announcements = [];

              for (var element in snapshot.data!.docs) {
                announcements.add(Announcement(element));
              }

              return ListView.builder(
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    return announcementTile(announcements[index]);
                  }
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }

  Widget announcementTile(Announcement announcement) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(announcement.object, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text("By ${fullName}", style: TextStyle(color: Colors.grey, fontSize: 15.0),),
            SizedBox(height: 5.0,),
            Text(announcement.message, style: TextStyle(fontSize: 18.0),)
          ],
        ),
      ),
    );
  }
}
