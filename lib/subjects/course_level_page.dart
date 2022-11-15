import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/subjects_navigation_tile.dart';
import 'package:go_dawg/subjects/class_selection_page.dart';

class CourseLevelPage extends StatelessWidget {
  const CourseLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> levels = ["Level 100", "Level 200", "Level 300"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Course Level"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return SubjectsNavigationTile(abbreviation: ((index+1)*100).toString(), text: levels[index], route: MaterialPageRoute(builder: (context) => const ClassSelectionPage()));
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
