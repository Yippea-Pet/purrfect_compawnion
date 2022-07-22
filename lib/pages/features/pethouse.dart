import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/pages/features/edit_name.dart';
import 'package:purrfect_compawnion/pages/features/user_guide.dart';
import 'package:purrfect_compawnion/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:purrfect_compawnion/shared/constants.dart';
import 'package:purrfect_compawnion/shared/loading.dart';
import '../../models/myuser.dart';
import '../../services/notification_services.dart';

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
  late bool doNotShowPetMaxLevelDialog;
  bool isChecked = false;
  bool loading = false;
  var db;
  late DateTime lastDeductTime;

  bool _isFeedButtonDisabled = false;
  int petState = 0; // 0(default):sleeping, 1: eating, 2: playing

  var notifyHelper;

  @override
  initState() {
    super.initState();
    scheduleTimeout(0);
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    scheduleNotifyHungry();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    db = FirebaseFirestore.instance;

    var petLevel = db.collection("users").doc(user.uid).collection("pet").doc("levels");
    petLevel.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      hungerLevel = data['hungerLevel'];
      friendshipLevel = data['friendshipLevel'];
      scheduleNotifyHungry();
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
    });

    var preference = db.collection("users").doc(user.uid).collection("preference").doc("friendshipLevel");
    preference.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      doNotShowPetMaxLevelDialog = data['doNotShow'] ?? false;
      setState(() {});
    });

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(name ?? 'Soccat!'),
              ),
              backgroundColor: appBarColor,
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
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return userGuide();
                        });
                  },
                    icon: Icon(Icons.question_mark_rounded),
                ),
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
                          if (_isFeedButtonDisabled) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("I need some time to chew! ><")),
                            );
                          } else if (foodQuantity > 0) {
                            setState(() {
                              foodQuantity -= 1;
                              hungerLevel += 1;
                              petState = 1;
                              _isFeedButtonDisabled = true;
                            });
                            scheduleResetSoccat(4900);
                            await DatabaseService(uid: user.uid).updateFoodData(
                                friendshipLevel, hungerLevel, foodQuantity);
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
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/FeedButton.png')
                        ),
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
                          if (friendshipLevel >= 100 && !doNotShowPetMaxLevelDialog) {
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
                                              fillColor: MaterialStateProperty.resolveWith(checkBoxMaterialState),
                                              value: doNotShowPetMaxLevelDialog,
                                              onChanged: (bool? value) async {
                                                setState(() {
                                                  doNotShowPetMaxLevelDialog = value ?? false;
                                                });
                                                await DatabaseService(uid: user.uid).doNotShowFriendshipLevelDialog(doNotShowPetMaxLevelDialog);
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
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/PlayButton.png')
                        ),
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

  void updateTime() async {
    final user = Provider.of<MyUser>(context, listen: false);
    var timeDoc = db.collection("users").doc(user.uid).collection("pet").doc("time");
    await timeDoc.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      lastDeductTime = data['time'].toDate();
    });
    final difference = lastDeductTime.difference(DateTime.now()).inHours;
    // final difference = DateTime.now().difference(lastDeductTime).inSeconds;
    if (difference >= 1) {
      await DatabaseService(uid: user.uid).updateDeductHungerTime(lastDeductTime.add(Duration(hours: difference)));
      // await DatabaseService(uid: user.uid).updateDeductHungerTime(lastDeductTime.add(Duration(minutes: difference)));
      // setState(() => lastDeductTime = lastDeductTime.add(Duration(seconds: difference)));
      // final finalHungerLevel = max(0, hungerLevel - (difference / 5).floor());
      final finalHungerLevel = max(0, hungerLevel - difference);
      await DatabaseService(uid: user.uid).updateDeductHungerTime(lastDeductTime);
      await DatabaseService(uid: user.uid).updatePetData(friendshipLevel, finalHungerLevel);
    }
  }

  Timer scheduleTimeout([int hours = 1]) => Timer(Duration(hours: hours), handleTimeout);
  Future<void> handleTimeout() async {
    updateTime();
    if (mounted) scheduleTimeout(1);
  }

  Timer scheduleResetSoccat([int milliseconds = 5100]) => Timer(Duration(milliseconds: milliseconds), resetSoccat);

  Future<void> resetSoccat() async {
    setState(() {
      petState = 0;
      _isFeedButtonDisabled = false;
    });
  }

  void scheduleNotifyHungry() {
    int hungryHour = hungerLevel;
    notifyHelper.scheduledHungryNotification(hungryHour);
  }
}
