
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginInfo extends ChangeNotifier {
  String? _userId;
  String? _userName;
  String? get userId => _userId;
  String? get userName => _userName;
  bool get loggedIn => checkIfLoggedIn();


  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

    _userId = userCredential.user?.uid;
    _userName = userCredential.user?.displayName;
    notifyListeners();
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();

    _userId = null;
    _userName = null;
    notifyListeners();
  }

  bool checkIfLoggedIn() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    _userId = user?.uid;
    _userName = user?.displayName;

    print("User" );
    print(_userId);

    return _userId != null;
  }
}


