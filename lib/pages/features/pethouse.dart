import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/pages/features/edit_name.dart';
import 'package:purrfect_compawnion/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:purrfect_compawnion/shared/constants.dart';
import 'package:purrfect_compawnion/shared/loading.dart';

import '../../models/myuser.dart';

class PetHouse extends StatefulWidget {
  const PetHouse({Key? key}) : super(key: key);

  @override
  State<PetHouse> createState() => _PetHouseState();
}

class _PetHouseState extends State<PetHouse> {
  int hungerLevel = 0;
  int friendshipLevel = 0;
  int foodQuantity = 0;
  String? name;
  bool showPetMaxLevelDialog = false;
  bool isChecked = false;
  bool loading = false;

  Future<Map<String, dynamic>>? petData;
  int petState = 0; // 0(default):sleeping, 1: eating, 2/3 to be added

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    var db = FirebaseFirestore.instance;

    var petLevel = db.collection("users").doc(user.uid).collection("pet").doc("levels");
    petLevel.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      hungerLevel = data['hungerLevel'];
      friendshipLevel = data['friendshipLevel'];
    });

    var foodData = db.collection("users").doc(user.uid).collection("pet").doc("food");
    foodData.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      foodQuantity = data['foodQuantity'];
    });

    var petName = db.collection("users").doc(user.uid).collection("pet").doc("name");
    petName.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      name = data['name'];
      setState(() {});
    });

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(name ?? 'Soccat!'),
              ),
              backgroundColor: Colors.red[200],
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return editName();
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                )
              ],
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
                      child: LinearPercentIndicator(
                        progressColor: Colors
                            .pink[max(1, (friendshipLevel / 20).floor()) * 100],
                        width: MediaQuery.of(context).size.width - 120,
                        animation: true,
                        lineHeight: 30.0,
                        percent: friendshipLevel / 100,
                        center: Text('${friendshipLevel}%'),
                        leading: Text("Friendship Level"),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Hunger Level: ${hungerLevel}'),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.grey,
                        elevation: 5.0,
                        color: Colors.pink[50],
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/FishIconThickerLineart.PNG',
                              width: 40,
                              height: 40,
                            ),
                            Text(" : ${foodQuantity}"),
                          ],
                        ),
                      )
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
                          if (foodQuantity > 0) {
                            print(foodQuantity);
                            setState(() {
                              foodQuantity -= 1;
                              hungerLevel += 1;
                              petState = 1;
                            });
                            await DatabaseService(uid: user.uid).updateFoodData(
                                friendshipLevel, hungerLevel, foodQuantity);
                            print(foodQuantity);
                          } else {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Warning!"),
                                      content: const Text(
                                          "You have 0 food left, complete more task to get more food!"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Icon(Icons.food_bank),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.pink[300]), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.pink; // <-- Splash color
                          }),
                        ),
                      ),
                      SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            friendshipLevel = min(friendshipLevel + 1, 100);
                            petState = 2;
                          });
                          await DatabaseService(uid: user.uid)
                              .updatePetData(friendshipLevel, hungerLevel);
                          if (friendshipLevel >= 100 &&
                              !showPetMaxLevelDialog) {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text("Congratulations!"),
                                        content: const Text(
                                            "You have reached the maximum friendship level with Soccat!"),
                                        actions: <Widget>[
                                          Text("Do not show this again"),
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(
                                                      checkBoxMaterialState),
                                              value: showPetMaxLevelDialog,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  showPetMaxLevelDialog =
                                                      value ?? false;
                                                });
                                              }),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      );
                                    }));
                          }
                        },
                        child: Icon(Icons.videogame_asset),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.pink[300]), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
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
  }
}
