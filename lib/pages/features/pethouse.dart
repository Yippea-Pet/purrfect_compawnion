import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/models/pet.dart';
import 'package:purrfect_compawnion/services/database.dart';
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
  int hygieneLevel = 0;

  @override
  Widget build(BuildContext context) {
    // final docUser = FirebaseFirestore.instance.collection("pets");
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<MyUser>(
        stream: DatabaseService(uid: user.uid).myUser,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            MyUser myUser = snapshot.data!;
            Pet? currentPet = myUser.pet;
            hungerLevel = currentPet!.hungerLevel;
            friendshipLevel = currentPet.friendshipLevel;
            hygieneLevel = currentPet.hygieneLevel;
            return Scaffold(
              appBar: AppBar(
                title: Text('Soccat!'),
                backgroundColor: Colors.red[200],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Hunger Level: ${hungerLevel}'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Friendship Level: ${friendshipLevel}'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Hygiene Level: ${hygieneLevel}'),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 9,
                      child: Image.asset('assets/MovingSoccat.GIF'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            setState(() => hungerLevel += 1);
                            await DatabaseService(uid: user.uid).updateUserData(friendshipLevel, hygieneLevel, hungerLevel);
                          },
                          child: Icon(Icons.food_bank),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red; // <-- Splash color
                            }),
                          ),
                        ),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() => friendshipLevel += 1);
                            await DatabaseService(uid: user.uid).updateUserData(friendshipLevel, hygieneLevel, hungerLevel);
                          },
                          child: Icon(Icons.videogame_asset),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red; // <-- Splash color
                            }),
                          ),
                        ),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() => hygieneLevel += 1);
                            await DatabaseService(uid: user.uid).updateUserData(friendshipLevel, hygieneLevel, hungerLevel);
                          },
                          child: Icon(Icons.cleaning_services),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red; // <-- Splash color
                            }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          // else {
          //   return Loading();
          // }
        });
  }
}
