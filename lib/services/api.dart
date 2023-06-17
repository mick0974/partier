import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<void> addEvent(String name, String description, DateTime date,
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
      "description": description,
      "owner": auth.currentUser!.uid.toString(),
      "creation_date": DateTime.now(),
      "event_date": date,
      "place": place,
      "public": true
    };

    print(event);

    await db.collection("events").add(event);
    print(db.collection("events").add(event));
  }

  Future<void> printTest() async {
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
