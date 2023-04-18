import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void signInWithGoogle() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

  AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken
  );

  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

  print(userCredential.user?.displayName);
}

void SignOut() async {
  await GoogleSignIn().signOut();
  FirebaseAuth.instance.signOut();
}