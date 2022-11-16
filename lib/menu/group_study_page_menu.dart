import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/text_field_appbar.dart';
import 'package:go_dawg/menu/group_study/group_study_page.dart';
import 'package:go_dawg/models/pair.dart';

class GroupStudyPageMenu extends StatefulWidget {
  const GroupStudyPageMenu({Key? key}) : super(key: key);

  @override
  State<GroupStudyPageMenu> createState() => _GroupStudyPageMenuState();
}

class _GroupStudyPageMenuState extends State<GroupStudyPageMenu> {

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
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("groupStudy").get(),
              builder: (context, snapshot) {
                List<Pair> courses = []; // id, name

                if (snapshot.connectionState == ConnectionState.done) {
                  for(var element in snapshot.data!.docs) {
                    courses.add(Pair(element.id, element.data()["name"]));
                  }

                  return ListView.builder(
                    itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return classTile(courses[index]);
                      }
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
          )
        ),
      ],
    );
  }

  Widget classTile(Pair course) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupStudyPage(course: course,))),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.deepPurple,
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(course.name, style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, color: Colors.white,)
              )
            ],
          )
        ),
      ),
    );
  }
}

