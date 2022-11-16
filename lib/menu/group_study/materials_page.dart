import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/models/pair.dart';

class MaterialsPage extends StatelessWidget {
  final Pair course;
  const MaterialsPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection("groupStudy").doc(course.id).collection("material").get(),
        builder: (context, snapshot) {
          List<GSMaterial> material = [];
          if (snapshot.connectionState == ConnectionState.done) {
            for(var element in snapshot.data!.docs) {
              Map<String, dynamic> data = element.data();
              material.add(GSMaterial(data["title"], data["description"], data["url"]));
            }

            return ListView.builder(
                itemCount: material.length,
                itemBuilder: (context, index) {
                  return materialTile(material[index]);
                }
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }

        }
      ),
    );
  }

  Widget materialTile(GSMaterial material) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(material.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text(material.description)
          ],
        )
      ),
    );
  }
}

class GSMaterial {
  final String title;
  final String description;
  final String url;

  GSMaterial(this.title, this.description, this.url);

}
