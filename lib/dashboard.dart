import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  final databaseReference = FirebaseDatabase.instance.reference();

  AnimationController? progressController;
  Animation<double>? tempAnimation;
  Animation<double>? humidityAnimation;

  double? co1;
  double? dust_density1;
  double? co2;
  double? dust_density2;

  @override
  void initState() {
    super.initState();
  }

  test() {
    //databaseReference.child("users").set('dd');

    databaseReference.once().then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }

  // _DashboardInit(double temp, double humid) {
  //   progressController = AnimationController(
  //       vsync: this, duration: Duration(milliseconds: 5000)); //5s
  //
  //   tempAnimation =
  //       Tween<double>(begin: -50, end: 10).animate(progressController!)
  //         ..addListener(() {
  //           setState(() {});
  //         });
  //
  //   humidityAnimation =
  //       Tween<double>(begin: 0, end: 100).animate(progressController!)
  //         ..addListener(() {
  //           setState(() {});
  //         });
  //
  //   progressController!.forward();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, AsyncSnapshot snap) {
            if (snap.hasData) {
              co1 = snap.data.snapshot.value['Tx1']['CO_level'];
              co2 = snap.data.snapshot.value['Tx2']['CO_level'];

              dust_density1 = snap.data.snapshot.value['Tx1']['DUST_density'];
              dust_density2 = snap.data.snapshot.value['Tx2']['DUST_density'];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Road 1',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CO_LEVEL : ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      co1.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DUST DENSITY : ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      dust_density1.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        const Text(
                          'Road 2',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CO_LEVEL : ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      co2.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DUST DENSITY : ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      dust_density2.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }

            return Container();
          },
        ));
  }
}

// Center(
// child: isLoading
// ? Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// CustomPaint(
// foregroundPainter: CircleProgress(
// tempAnimation!.value, true),
// child: Container(
// width: 200,
// height: 200,
// child: Center(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: <Widget>[
// const Text('Temperature'),
// Text(
// '${tempAnimation!.value.toInt()}',
// style: const TextStyle(
// fontSize: 50,
// fontWeight:
// FontWeight.bold),
// ),
// const Text(
// '°C',
// style: TextStyle(
// fontSize: 20,
// fontWeight:
// FontWeight.bold),
// ),
// ],
// ),
// ),
// ),
// ),
// CustomPaint(
// foregroundPainter: CircleProgress(
// humidityAnimation!.value, false),
// child: Container(
// width: 200,
// height: 200,
// child: Center(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: <Widget>[
// const Text('Humidity'),
// Text(
// '${humidityAnimation!.value.toInt()}',
// style: TextStyle(
// fontSize: 50,
// fontWeight:
// FontWeight.bold),
// ),
// const Text(
// '%',
// style: TextStyle(
// fontSize: 20,
// fontWeight:
// FontWeight.bold),
// ),
// ],
// ),
// ),
// ),
// )
// ],
// )
// : const Text(
// 'Loading...',
// style: TextStyle(
// fontSize: 30,
// fontWeight: FontWeight.bold),
// )),
