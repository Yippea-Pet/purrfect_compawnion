import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food');

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
      "id": task?.id,
      "title": task?.title,
      "note": task?.note,
      "isCompleted": task?.isCompleted,
      "date": task?.date,
      "startTime": task?.startTime,
      "endTime": task?.endTime,
      "color": task?.color,
      "remind": task?.remind,
      "repeat": task?.repeat,
    });
  }

  Future deleteTask(String? id) async {
    return await users.doc(uid).collection("tasks").doc(id).delete();
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Task(
              id: doc.id as int,
              title: doc.get('title'),
              note: doc.get('note'),
              isCompleted: doc.get('isCompleted'),
              date: doc.get('date'),
              startTime: doc.get('startTime'),
              endTime: doc.get('endTime'),
              color: doc.get('color'),
              remind: doc.get('remind'),
              repeat: doc.get('repeat'),
            ))
        .toList();
  }

  // Get Stream of brews
  Stream<List<Task>> get tasks {
    final CollectionReference taskCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection("tasks");
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

}
