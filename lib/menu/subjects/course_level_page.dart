import 'package:flutter/material.dart';

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
              return Container();
              //return SubjectsNavigationTile(abbreviation: ((index+1)*100).toString(), text: levels[index], route: MaterialPageRoute(builder: (context) => ClassSelectionPage(abbreviation: ab,)));
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
