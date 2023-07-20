import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Api {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Api();

  /// Given specified parameters verifies if the event can be added to the
  /// database
  void verifyEvent() {

  }

  /// Adds an event to the database.
  /// Requires as input: the event's name, the event's description, the event's
  /// date and the event's place.
  Future<void> addEvent(String name, String dressCode, String description, DateTime date,
      GeoPoint place) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    /*
    final event = <String, dynamic>{
      "name_event": "Quando mia nonna non c'è",
      "description": "I topi ballano",
      "owner": auth.currentUser!.uid.toString(),
      "creation_date": DateTime.now(),
      "event_date": DateTime.now(),
      "place": GeoPoint(2, 2),
      "public": true
    };
     */

    final event = <String, dynamic>{
      "name_event": name,
      "dress_code": dressCode,
      "description": description,
      "owner": auth.currentUser!.uid.toString(),
      "creation_date": DateTime.now(),
      "event_date": date,
      "place": place,
      "public": true
    };

    print(event);

    await db.collection("events").add(event);
  }

  Future<void> printTest() async {
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  /// Gets the id of current user and returns it as a string.
  Future<String> getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser!.uid;
    print(uid);

    return uid.toString();
  }

  /// Adds current user to specified event.
  Future addUser(String eventId) async {
    //final uid = getCurrentUser();
    //final event = db.collection('events').doc(eventId).get();
    //            = db.collection("events").where(
    //                firebase.firestore.FieldPath.documentId(), '==', eventId
    //              ).get();
    String? userName = GoogleSignIn().currentUser?.displayName;
    userName ??= 'Failed to get displayName';

    db.collection('events').doc(eventId).collection('guests').add({
      'id': await getCurrentUser(),
      'name': userName,
    });
  }
}