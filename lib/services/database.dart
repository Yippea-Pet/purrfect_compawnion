import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future updatePetData(int friendshipLevel, int hungerLevel) async {
    return await users.doc(uid).collection("pet").doc("levels").set({
      'friendshipLevel': friendshipLevel,
      'hungerLevel': hungerLevel,
    });
  }

  Future updateFoodData(
      int friendshipLevel, int hungerLevel, int foodQuantity) async {
    await users.doc(uid).collection("pet").doc("food").set({
      'foodQuantity': foodQuantity,
    });
    return await users.doc(uid).collection("pet").doc("levels").set({
      'friendshipLevel': friendshipLevel,
      'hungerLevel': hungerLevel,
    });
  }

  Future updatePetName(String name) async {
    return await users.doc(uid).collection("pet").doc("name").set({
      'name': name,
    });
  }

  Future updateDeductHungerTime(DateTime time) async {
    return await users.doc(uid).collection("pet").doc("time").set({
      'time': time,
    });
  }

  Future addTask(Task? task) async {
    return await users.doc(uid).collection("tasks").add({
      "title": task?.title,
      "note": task?.note,
      "isCompleted": task?.isCompleted,
      "date": task?.date,
      "startTime": task?.startTime,
      "endTime": task?.endTime,
      "color": task?.color,
      "remind": task?.remind,
      "repeat": task?.repeat,
      "difficulty": task?.difficulty,
    });
  }

  Future deleteTask(String? id) async {
    return await users.doc(uid).collection("tasks").doc(id).delete();
  }

  Future completeTask(String? id, int? difficulty) async {
    await users.doc(uid).collection("pet").doc("food").update({
      'foodQuantity': FieldValue.increment((difficulty ?? 0) + 1),
    });
    return await users.doc(uid).collection("tasks").doc(id).update({
      "isCompleted": 1,
    });
  }
}
