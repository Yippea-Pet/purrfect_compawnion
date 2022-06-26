import 'package:firebase_auth/firebase_auth.dart';
import 'package:purrfect_compawnion/services/database.dart';

import '../models/myuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        // .map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously (this will be async task)
  Future signInAnon() async {
    // might cause error
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updatePetData(0, 100);
      return _userFromFirebaseUser(user);
  }

  // sign out
  Future signOut() async {
    try {
      // signOut() here is the built-in function for FirebaseAuth,
      // it is different with the one at line 1
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
