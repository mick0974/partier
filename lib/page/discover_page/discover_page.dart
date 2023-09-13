import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:partier/services/auth_service.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partier/services/api.dart';
import '../../model/event.dart';


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
  var api = Api();
  var loginInfo = LoginInfo();  /// TODO: Not saving login info

  List events = [];
  List<Widget> eventContainers = [];
  bool firstUpdate = true;
  int counter = 0;


  void createEventContainers(List ev) {
    eventContainers = [];
    for (var i = 0; i < min(ev.length,3); i++){
      var tmpId = ev[i].keys.toList()[0];
      var tmp = ev[i].values.toList()[0];
      var date = DateTime.fromMillisecondsSinceEpoch(tmp["event_date"].seconds * 1000);

      eventContainers.add(
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
            child: MyFancyContainer(
              id: tmpId,
              title: tmp["name_event"],
              date: "${date.day}-${date.month}-${date.year}",
            )
        )
      );
    }
  }

  void updateEventsList({bool reset = true}) {
    //https://firebase.google.com/docs/firestore/query-data/get-data
    counter++;

    if(reset) counter = 0;
    firstUpdate = !(counter > 1);

    FirebaseFirestore.instance.collection("events")
      .where("public", isEqualTo: true)
      .where("event_date", isGreaterThan: DateTime.now())
      .get().then(
        (querySnapshot) {
          events = [];

          for (var docSnapshot in querySnapshot.docs) {
            setState(() {
              events.add({docSnapshot.id: docSnapshot.data()});
            });
          }
        },
        onError: (e) => print("Error completing: $e"),
      );

    createEventContainers(events);
  }

  @override
  Widget build(BuildContext context) {
    if(firstUpdate) updateEventsList(reset: false);
    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: SafeArea(
              child: FilledButton.icon(
                onPressed: updateEventsList,
                icon: const Icon(Icons.update),
                label: const Text('Tap to reload'),
              )
            ),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildListDelegate(
              eventContainers,
            ),
          ),
        ],
      ),
    );
  }
}

/*
class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['full_name']),
                  subtitle: Text(data['company']),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
 */