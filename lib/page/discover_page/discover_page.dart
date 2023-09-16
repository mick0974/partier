import 'package:flutter/material.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/// Home page of the application.
/// This widget will contain an upper bar and an istance of page widget. In
/// particular, through a button will get access to the user's options.
class DiscoverPage extends StatefulWidget {
  final String title = 'Partier';

  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPage();
}

class _DiscoverPage extends State<DiscoverPage> {
  /// TODO: Not saving login info
  //var api = Api();
  //var loginInfo = LoginInfo();

  final Stream<QuerySnapshot> _eventsStream =
    FirebaseFirestore.instance.collection('events')
    .where("public", isEqualTo: true)
    .where("event_date", isGreaterThan: DateTime.now())
    .snapshots();

  /// Given a query snapshot, creates a list of widgets representing events
  /// retrieved by the stream.
  List<Widget> createEventContainers(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

        var date =
          DateTime.fromMillisecondsSinceEpoch(data['event_date'].seconds * 1000);

        return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
            child: MyFancyContainer(
              id: doc.id,
              title: data['name_event'],
              date: "${date.day}-${date.month}-${date.year}",
            )
        );
      })
      .toList()
      .cast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _eventsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Widget disc;

          if (snapshot.hasError) {
            disc = const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            disc = const Text("Loading");
          } else {
            disc = ListView(
              children: createEventContainers(snapshot),
            );
          }

          return disc;
        },
      )
    );
  }
}