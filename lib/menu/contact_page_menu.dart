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
        TextFieldAppBar(controller: _contactController, hint: "Search a professor", icon: CupertinoIcons.person_circle),
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
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://res.cloudinary.com/glide/image/fetch/t_media_lib_thumb/https%3A%2F%2Fstorage.googleapis.com%2Fglide-prod.appspot.com%2Fuploads-v2%2FhjRb2VbsHzaT2GFjjfMN%2Fpub%2FQ71MWFIswMSPPX1QgZ0Q.jpeg")),
                  shape: BoxShape.circle,
                  color: Colors.deepPurpleAccent
                ),
              ),
              const SizedBox(width: 5.0,),
              Text(professor.name, style: const TextStyle(fontSize: 17.0),)
            ],
          ),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}


