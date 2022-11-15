import 'package:flutter/material.dart';
import 'package:go_dawg/subjects/class_registration_page.dart';

class ClassSelectionPage extends StatelessWidget {
  const ClassSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> classes = ["CS 170", "CS 180", "CS 181"];
    List<String> descs = ["Intro to Computer Science I", "Foundations of Computer Science I", "Foundations of Computer Science II", "Computing Structures"];
    List<String> terms = ["CS Spring 2023", "CS Summer 2023", "CS Fall 2023", "CS Spring 2023"];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Course Level"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return classTile(context, classes[index], "C1", descs[index], terms[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 3
        ),
      ),
    );
  }
  
  Widget classTile(BuildContext context, String name, String abbreviation, String desc, String term) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassRegistrationPage())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold),),
              Text(desc),
              Text(term, style: const TextStyle(color: Colors.grey),)
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
