import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/text_field_appbar.dart';

class GroupStudyPage extends StatefulWidget {
  const GroupStudyPage({Key? key}) : super(key: key);

  @override
  State<GroupStudyPage> createState() => _GroupStudyPageState();
}

class _GroupStudyPageState extends State<GroupStudyPage> {

  late TextEditingController _groupStudyController;

  @override
  void initState() {
    super.initState();
    _groupStudyController = TextEditingController();
  }

  @override
  void dispose() {
    _groupStudyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldAppBar(controller: _groupStudyController, hint: "Class name", icon: Icons.developer_board),
        Expanded(
          child: ListView(
            children: [
              classTile("CS 170"),
              classTile("CS 250"),
              classTile("CS 380")
            ],
          ),
        ),
      ],
    );
  }

  Widget classTile(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.deepPurple,
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: Colors.white,)
            )
          ],
        )
      ),
    );
  }
}
