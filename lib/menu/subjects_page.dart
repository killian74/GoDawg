import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/Widgets/text_field_appbar.dart';
import 'package:go_dawg/subjects/term_page.dart';


class SubjectsPage extends StatefulWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {

  late TextEditingController _subjectsController;

  @override
  void initState() {
    super.initState();
    _subjectsController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TextFieldAppBar(controller: _subjectsController, hint: "Course name", icon: CupertinoIcons.book,),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(5.0),
              childAspectRatio: 1.5,
              crossAxisCount: 2,
              children: [
                courseTile("Computer Science", "images/cs.jpg"),
                courseTile("Math", "images/math.jpg"),
                courseTile("Business Administration", "images/ba.jpg"),
                courseTile("Exercise science", "images/exercise_science.jpg")
              ],
            ),
          )
        ],
      );
  }

  Widget courseTile(String name, String image) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermPage(abbreviation: "CS"))),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            ),
          ),
          child: Center(child: Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,)),
        ),
      ),
    );
  }
}
