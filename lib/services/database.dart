import 'package:cloud_firestore/cloud_firestore.dart';

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
}