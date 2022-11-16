import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/menu/subjects/class_selection_page.dart';

class TermPage extends StatelessWidget {
  final String abbreviation;

  const TermPage({Key? key, required this.abbreviation}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Terms"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("registration").get(),
            builder: (content, snapshot) {
            List<String> terms = [];
              if(snapshot.connectionState == ConnectionState.done) {
                for (var element in snapshot.data!.docs) {
                  terms.add(element.id);
                }
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      return termTile(context, terms[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: terms.length
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
        )
      ),
    );
  }

  String getRealTermName(String term) {
    if (term == "spring2023") {
      return "Spring 2023";
    } else if (term == "summer2023") {
      return "Summer 2023";
    } else if (term == "fall2023") {
      return "Fall 2023";
    }

    return "Unknown";

  }
  
  Widget termTile(BuildContext context, String term) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ClassSelectionPage(abbreviation: abbreviation, term: term,)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(width: 5.0,),
              Text(getRealTermName(term), style: const TextStyle(fontSize: 17.0),)
            ],
          ),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}
