import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference foodCollection = FirebaseFirestore.instance.collection('food');

  Future updatePetData(int friendshipLevel, int hungerLevel) async {
    return await users.doc(uid).collection("pet").doc("levels").set({
      'friendshipLevel' : friendshipLevel,
      'hungerLevel' : hungerLevel,
    });
  }

  Future updateFoodData(int friendshipLevel, int hungerLevel, int foodQuantity) async {
    await users.doc(uid).collection("pet").doc("food").set({
      'foodQuantity' : foodQuantity,
    });
    return await users.doc(uid).collection("pet").doc("levels").set({
      'friendshipLevel' : friendshipLevel,
      'hungerLevel' : hungerLevel,
    });
  }

  Future updatePetName(String name) async {
    return await users.doc(uid).collection("pet").doc("name").set({
      'name' : name,
    });
  }
}