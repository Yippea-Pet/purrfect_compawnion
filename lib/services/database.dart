import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purrfect_compawnion/models/myuser.dart';
import 'package:purrfect_compawnion/models/pet.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');

  Future updateUserData(int friendshipLevel, int hygieneLevel, int hungerLevel) async {
    print(friendshipLevel);
    return await petCollection.doc(uid).set({
      'friendshipLevel' : friendshipLevel,
      'hygieneLevel' : hygieneLevel,
      'hungerLevel' : hungerLevel,
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