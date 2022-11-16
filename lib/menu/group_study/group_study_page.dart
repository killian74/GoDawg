import 'package:flutter/material.dart';
import 'package:go_dawg/menu/group_study/materials_page.dart';
import 'package:go_dawg/menu/group_study/peer_page.dart';
import 'package:go_dawg/menu/group_study/tutoring_page.dart';
import 'package:go_dawg/models/pair.dart';

class GroupStudyPage extends StatefulWidget {
  final Pair course;
  const GroupStudyPage({Key? key, required this.course}) : super(key: key);

  @override
  State<GroupStudyPage> createState() => _GroupStudyPageState();
}

class _GroupStudyPageState extends State<GroupStudyPage> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    int tabIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
        bottom: TabBar(
            onTap: (int i) {
              setState(() {
                tabIndex = i;
              });
            },
            controller: _tabController,
            tabs: const [
              Tab(text: "Material"),
              Tab(text: "Tutoring"),
              Tab(text: "Peer"),
            ]
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MaterialsPage(course: widget.course,),
          TutoringPage(course: widget.course,),
          PeerPage()
        ],
      ),
    );
  }
}
