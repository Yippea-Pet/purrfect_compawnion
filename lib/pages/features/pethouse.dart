import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/models/pet.dart';
import 'package:purrfect_compawnion/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/myuser.dart';

class PetHouse extends StatefulWidget {
  const PetHouse({Key? key}) : super(key: key);

  @override
  State<PetHouse> createState() => _PetHouseState();
}

class _PetHouseState extends State<PetHouse> {
  int hungerLevel = 0;
  int friendshipLevel = 0;
  int hygieneLevel = 0;
  Future<Map<String, dynamic>>? petData;
  int petState = 0; // 0(default):sleeping, 1: eating, 2/3 to be added
/*
  @override
  void initState() {
    Future petData = readData();
    super.initState();
  }

  Future readData() async {
    final user = Provider.of<MyUser>(context);
    Map<String, dynamic> data;
    var db = FirebaseFirestore.instance;
    var pet = db.collection("pets").doc(user.uid);
    pet.get().then((DocumentSnapshot doc) async {
      data = doc.data() as Map<String, dynamic>;
      hungerLevel = data['hungerLevel'];
      friendshipLevel = data['friendshipLevel'];
      hygieneLevel = data['hygieneLevel'];
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    var db = FirebaseFirestore.instance;
    var pet = db.collection("pets").doc(user.uid);
    pet.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      hungerLevel = data['hungerLevel'];
      friendshipLevel = data['friendshipLevel'];
      hygieneLevel = data['hygieneLevel'];
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Soccat!'),
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/PetHouseBackground.png"),
          fit: BoxFit.cover,
        )),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                // child: Text('Friendship Level: ${friendshipLevel}'),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 120,
                  animation: true,
                  lineHeight: 20.0,
                  percent: friendshipLevel / 100,
                  center: Text('${friendshipLevel}%'),
                  leading: Text("Friendship Level"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Hunger Level: ${hungerLevel}'),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Hygiene Level: ${hygieneLevel}'),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 9,
              child: petState == 0
                  ? Image.asset('assets/SoccatSleep.PNG')
                  : petState == 1
                      ? Image.asset('assets/SoccatNomming.GIF')
                      : Image.asset('assets/MovingSoccat.GIF'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      hungerLevel += 1;
                      petState = 1;
                    });
                    await DatabaseService(uid: user.uid).updateUserData(
                        friendshipLevel, hygieneLevel, hungerLevel);
                  },
                  child: Icon(Icons.food_bank),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.pink[300]), // <-- Button color
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.pink; // <-- Splash color
                    }),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      friendshipLevel += 1;
                      petState = 2;
                    });
                    await DatabaseService(uid: user.uid).updateUserData(
                        friendshipLevel, hygieneLevel, hungerLevel);
                  },
                  child: Icon(Icons.videogame_asset),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.pink[300]), // <-- Button color
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.pink; // <-- Splash color
                    }),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      hygieneLevel += 1;
                      petState = 3;
                    });
                    await DatabaseService(uid: user.uid).updateUserData(
                        friendshipLevel, hygieneLevel, hungerLevel);
                  },
                  child: Icon(Icons.cleaning_services),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.pink[300]), // <-- Button color
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.pink; // <-- Splash color
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
    // }
    // else {
    //   return Loading();
    // }
    // });
  }
}
