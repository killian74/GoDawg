import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/subjects_navigation_tile.dart';
import 'package:go_dawg/subjects/course_level_page.dart';

class TermPage extends StatelessWidget {
  final String abbreviation;

  const TermPage({Key? key, required this.abbreviation}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> terms = ["Spring 2023", "Summer 2023", "Fall 2023"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Term"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return SubjectsNavigationTile(abbreviation: abbreviation, text: terms[index], route: MaterialPageRoute(builder: (context) => const CourseLevelPage()));
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 3
        ),
      ),
    );
  }
}
