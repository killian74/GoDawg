import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/models/course.dart';
import 'package:go_dawg/menu/subjects/class_registration_page.dart';

class ClassSelectionPage extends StatelessWidget {
  final String abbreviation;
  final String term;
  const ClassSelectionPage({Key? key, required this.abbreviation, required this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> classes = ["CS 170", "CS 180", "CS 181"];
    List<String> descs = ["Intro to Computer Science I", "Foundations of Computer Science I", "Foundations of Computer Science II", "Computing Structures"];
    List<String> terms = ["CS Spring 2023", "CS Summer 2023", "CS Fall 2023", "CS Spring 2023"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("$abbreviation ${getRealTermName(term)}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("registration").doc(term).collection(abbreviation).get(),
            builder: (context, snapshot) {
              List<Course> courses = [];
              if(snapshot.connectionState == ConnectionState.done) {

                for (var element in snapshot.data!.docs) {
                  courses.add(Course(element, abbreviation, getRealTermName(term)));
                }

                if (courses.isEmpty) {
                  return const Center(child: Text("There is currently no classes available for this term"),);
                } else {
                  return ListView.separated(
                      itemBuilder: (ctx, index) {
                        return classTile(context, courses[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: courses.length
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        )
      ),
    );
  }

  String getRealTermName(String term) {
    if (term == "spring2023") {
      return "Spring 2023";
    } else if (term == "summer2023") {
      return "Summer 2023";
    } else if (term == "fall2023") {
      return "Fall 2023";
    }

    return "Unknown";

  }
  
  Widget classTile(BuildContext context, Course course) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassRegistrationPage(course: course,))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold),),
              Text(course.shortDesc),
              Text(getRealTermName(term), style: const TextStyle(color: Colors.grey),)
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(abbreviation, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
