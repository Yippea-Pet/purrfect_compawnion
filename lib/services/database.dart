import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purrfect_compawnion/models/myuser.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');
  final CollectionReference foodCollection = FirebaseFirestore.instance.collection('food');

  Future updatePetData(int friendshipLevel, int hungerLevel) async {
    return await petCollection.doc(uid).set({
      'friendshipLevel' : friendshipLevel,
      'hungerLevel' : hungerLevel,
    });
  }

  Future updateFoodData(int friendshipLevel, int hungerLevel, String foodType, int foodQuantity) async {
    return await petCollection.doc(uid).set({
      'friendshipLevel' : friendshipLevel,
      'hungerLevel' : hungerLevel,
      foodType : foodQuantity,
    });
  }

  MyUser _userFromSnapshot(DocumentSnapshot snapshot) {
    return MyUser(
      uid: uid,
      pet: snapshot['pet'],
    );
  }

  Stream<MyUser> get myUser {
    return petCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}