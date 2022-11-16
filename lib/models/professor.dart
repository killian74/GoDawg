import 'package:cloud_firestore/cloud_firestore.dart';

class Professor {
  late String uid;
  late String imageUrl;
  late String name;
  late Map<String, dynamic> schedule;
  late String location;

  Professor(DocumentSnapshot<Map<String, dynamic>>? snapshot) {
    Map<String, dynamic> map = snapshot!.data() as Map<String, dynamic>;

    uid = snapshot.id;
    name = map["name"];
    schedule = map["schedule"];
    location = map["location"];
    imageUrl = map["imageUrl"];


  }
}