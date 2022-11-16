import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/text_field_appbar.dart';
import 'package:go_dawg/menu/contact/professor_page.dart';
import 'package:go_dawg/models/professor.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  late TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _contactController = TextEditingController();
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldAppBar(controller: _contactController, hint: "Search a professor/department", icon: CupertinoIcons.person_circle),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("professors").get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Professor> professors = [];

                      for(var element in snapshot.data!.docs) {
                        professors.add(Professor(element));
                      }

                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return professorTile(professors[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: professors.length
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  }
              ),
            )
        )
      ],
    );
  }

  Widget professorTile(Professor professor) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ProfessorPage(professor: professor)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(professor.imageUrl)),
                    shape: BoxShape.circle,
                    color: Colors.deepPurpleAccent
                ),
              ),
              const SizedBox(width: 5.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(professor.name, style: const TextStyle(fontSize: 17.0),),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.location_solid, color: Colors.grey, size: 15.0,),
                      Text(professor.location, style: const TextStyle(fontSize: 14.0, color: Colors.grey),),
                    ],
                  ),
                ],
              )
            ],
          ),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}


