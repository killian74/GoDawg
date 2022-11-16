import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  late String userName;
  late String object;
  late String message;

  Announcement(DocumentSnapshot<Map<String, dynamic>>? snapshot) {
    Map<String, dynamic> map = snapshot!.data() as Map<String, dynamic>;

    userName = map["userName"];
    object = map["object"];
    message = map["message"];

  }


}