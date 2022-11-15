import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  late String uid;
  late String email;
  late String fullName;
  late List<dynamic> majors;
  late List<dynamic> minors;
  late int phone;
  late String status;
  late int studentId;

  AppUser(DocumentSnapshot<Map<String, dynamic>>? snapshot) {
    Map<String, dynamic> map = snapshot!.data() as Map<String, dynamic>;

    uid = map["uid"];
    email = map["email"];
    fullName = map["fullName"];
    majors = map["majors"];
    minors = map["minors"];
    phone = map["phone"];
    status = map["status"];
    studentId = map["studentId"];
  }
}