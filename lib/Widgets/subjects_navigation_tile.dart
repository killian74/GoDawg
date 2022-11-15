import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectsNavigationTile extends StatelessWidget {
  final String abbreviation;
  final String text;
  final MaterialPageRoute route;
  const SubjectsNavigationTile({Key? key, required this.abbreviation, required this.text, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(route),
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
              Text(text, style: const TextStyle(fontSize: 17.0),)
            ],
          ),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}
