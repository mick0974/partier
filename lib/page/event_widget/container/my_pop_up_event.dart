import 'package:flutter/material.dart';

import '../myPoll.dart';
import '../../../services/api.dart';
import '../poll.dart';

class MyPopupEvent extends StatefulWidget {
  const MyPopupEvent({
    super.key,
    required this.title,
    required this.image_path,
    required this.date,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  final String date;
  final String image_path;

  @override
  _MyPopupEventState createState() => _MyPopupEventState();
}

class _MyPopupEventState extends State<MyPopupEvent>{

  bool option_1 = false;
  bool option_2 = false;
  bool option_3 = false;
  bool option_4 = false;


  Widget _buildPoll(BuildContext context) {

    return Poll(
      title: 'Drinks',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        snap: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              appBar: AppBar(
                title: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                bottom: const TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.cloud_outlined),
                      text: 'Summary',
                    ),
                    Tab(
                      icon: Icon(Icons.beach_access_sharp),
                      text: 'Participants',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  ListView(
                    //shrinkWrap: true,
                    controller: scrollController,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Time left:',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.date),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18.0,),
                          const Divider(
                            color: Colors.grey,
                            height: 4.0,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.805,
                            height: MediaQuery.of(context).size.height*0.09,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.image_path ?? 'assets/images/sanremo.jpg'),
                                opacity: 0.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 4.0,
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                                top: 5.0, bottom: 20.0),
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  "Descrizione:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                                ),
                                Text(
                                  widget.subtitle ?? "Un magnifico evento!",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15.0,),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 5.0,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                                    top: 5.0, bottom: 10.0),
                                child: const Text("Sondaggio"),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _buildPoll(context),
                                  );
                                },
                                child: const Text('Drinks'),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 5.0,
                          ),
                          /*
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                                    top: 5.0, bottom: 10.0),
                                child: const Text("Partecipanti"),
                              ),
                            ],
                          ),
                          Expanded(
                            child: GridView.count(
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this would produce 2 rows.
                              crossAxisCount: 3,
                              // Generate 100 Widgets that display their index in the List
                              children: List.generate(9, (index) {
                                return Center(
                                  child: Text(
                                    'Utente $index',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }),
                            ),
                          ),
                          InkWell(
                            child: GestureDetector(
                              onTap: () {print("Il listener funziona!");},
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(32.0),
                                      bottomRight: Radius.circular(32.0)),
                                ),
                                child: const Text(
                                  'Iscriviti!',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          */
                        ],
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Column(
                        children: const [
                          Text('Participants'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

