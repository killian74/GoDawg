import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ClassRegistrationPage extends StatefulWidget {
  const ClassRegistrationPage({Key? key}) : super(key: key);

  @override
  State<ClassRegistrationPage> createState() => _ClassRegistrationPageState();
}

class _ClassRegistrationPageState extends State<ClassRegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CS 170"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const [
                            Text("Intro to Computer Science I", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                            Text("CS Spring 2023", style: TextStyle(color: Colors.grey, fontSize: 18.0),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Professor", style: TextStyle(color: Colors.grey, fontSize: 18.0),),
                            Text("Kafi Rahman", style: TextStyle(color: Colors.black, fontSize: 18.0),),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurpleAccent
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.person, color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Rating", style: TextStyle(color: Colors.grey, fontSize: 18.0),),
                            Text("4/5", style: TextStyle(color: Colors.black, fontSize: 18.0),),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 35.0,),
                            Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 35.0,),
                            Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 35.0,),
                            Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 35.0,),
                            Icon(CupertinoIcons.star_fill, color: Colors.grey, size: 35.0,),

                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    const Text("Description", style: TextStyle(color: Colors.grey, fontSize: 18.0),),
                    const Text("Introduction to key ideas of computing and programming. Basic concepts, variables, functions, loops, algorithms, data types, graphics. Brief introduction to computing ideas such as data representation, hardware, operating systems, information systems, artificial intelligence, networks, and the world wide web.", style: TextStyle(color: Colors.black, fontSize: 18.0),),
                    const SizedBox(height: 15.0,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Difficulty Level", style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),

                    SfRadialGauge(enableLoadingAnimation: true, axes: <RadialAxis>[
                      RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          startAngle: 180,
                          endAngle: 0,
                          radiusFactor: 0.7,
                          canScaleToFit: false,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.1,
                            color: Color.fromARGB(30, 0, 169, 181),
                            thicknessUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.startCurve,
                          ),
                          pointers: const <GaugePointer>[
                            RangePointer(
                              color: Colors.deepPurpleAccent,
                                value: 80,
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve)
                          ],)
                    ]),

                  ],
                )
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                minimumSize: const Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {},
              child: const Text('Register', style: TextStyle(fontSize: 20.0),),
            )
          ],
        ),
      ),
    );
  }
}
