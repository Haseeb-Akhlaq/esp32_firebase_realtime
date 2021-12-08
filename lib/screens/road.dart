import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Road1 extends StatefulWidget {
  final String? roadName;
  final String? roadCode;
  const Road1({Key? key, this.roadCode, this.roadName}) : super(key: key);

  @override
  State<Road1> createState() => _Road1State();
}

class _Road1State extends State<Road1> {
  final databaseReference = FirebaseDatabase.instance.reference();

  double? co_level;
  double? dust_density;
  String? co_level_l;
  String? dust_density_l;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roadName!,
          style: const TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            co_level = snap.data.snapshot.value[widget.roadCode]['CO_level']
                .toDouble();
            co_level_l =
                snap.data.snapshot.value[widget.roadCode]['CO_level_L'];

            dust_density = snap
                .data.snapshot.value[widget.roadCode]['DUST_density']
                .toDouble();
            dust_density_l =
                snap.data.snapshot.value[widget.roadCode]['DUST_density_L'];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CO_LEVEL : ',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${co_level.toString()} ppm',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CO_LEVEL : ',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    co_level_l.toString(),
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DUST DENSITY : ',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    dust_density.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    ' µg/m3 PM10',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DUST DENSITY : ',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    dust_density_l.toString(),
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Image.asset(
                'assets/images/loader.gif',
                height: 50,
                width: 50,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
