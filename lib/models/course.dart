import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  late String crn;
  late String name;
  late Map<String, dynamic> schedule;
  late List<dynamic> enrollment;
  late int section;
  late String professor;
  late String term;
  late int capacity;
  late String shortDesc;
  late String longDesc;
  late String abbreviation;
  late int rating;
  late int difficulty;

  Course(DocumentSnapshot<Map<String, dynamic>>? snapshot, String abbrev, String t) {
    Map<String, dynamic> map = snapshot!.data() as Map<String, dynamic>;

    crn = snapshot.id;
    term = t;
    abbreviation = abbrev;
    name = map["name"];
    schedule = map["schedule"];
    enrollment = map["enrollment"];
    section = map["section"];
    professor = map["professor"];
    capacity = map["capacity"];
    shortDesc = map["shortDesc"];
    longDesc = map["longDesc"];
    rating = map["rating"];
    difficulty = map["difficulty"];

  }
}