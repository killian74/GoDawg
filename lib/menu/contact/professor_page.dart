import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_dawg/models/professor.dart';

class ProfessorPage extends StatelessWidget {
  final Professor professor;
  const ProfessorPage({Key? key, required this.professor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(professor.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(professor.name, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Icon(CupertinoIcons.location_solid, color: Colors.grey, size: 20.0,),
                Text(professor.location, style: TextStyle(fontSize: 18.0, color: Colors.grey),),
              ],
            ),
            SizedBox(height: 5.0,),
            if (professor.phoneNumber != "")
              Row(
                children: [
                  Icon(CupertinoIcons.phone, color: Colors.grey, size: 20.0,),
                  Text(professor.phoneNumber, style: TextStyle(fontSize: 18.0, color: Colors.grey),)
                ]
              ),
            const Divider(),
            for (var i in professor.schedule.entries)
              Text("${i.key} : ${i.value}", style: TextStyle(fontSize: 18.0),)
          ],
        ),
      ),
    );
  }
}
