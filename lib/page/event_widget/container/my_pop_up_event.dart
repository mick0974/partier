import 'package:flutter/material.dart';

import '../myPoll.dart';
import '../../../services/api.dart';

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


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 15.0,),
      content: Container(
        width: MediaQuery.of(context).size.height*0.75,
        height: MediaQuery.of(context).size.height*0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Container(

                ),
                Text(widget.date)
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Divider(
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

            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            Container(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                  top: 5.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Descrizione:",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    widget.subtitle ?? "Un magnifico evento!",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 5.0,
            ),
            Expanded(child: SingleChildScrollView(
                child:Column(
                  children: <Widget>[

                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                          top: 5.0, bottom: 10.0),
                      child: Text("Sondaggio"),
                    ),
                    MyPoll(
                      label: 'Jack & Cola',
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      value: this.option_1,
                      onChanged: (bool newValue) {
                        setState(() {
                          this.option_1 = newValue;
                          print(this.option_1);
                        });
                      },
                    ),
                    MyPoll(
                      label: 'Gin Lemon',
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      value: this.option_2,
                      onChanged: (bool newValue) {
                        setState(() {
                          this.option_2 = newValue;
                          print(this.option_2);
                        });
                      },
                    ),
                    MyPoll(
                      label: 'Aperol Spritz',
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      value: this.option_3,
                      onChanged: (bool newValue) {
                        setState(() {
                          this.option_3 = newValue;
                          print(this.option_3);
                        });
                      },
                    ),

                    Divider(
                      color: Colors.grey,
                      height: 5.0,
                    ),

                  ],
                )

            ),
            ),

            Column(
              children: [Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,
                    top: 5.0, bottom: 10.0),
                child: Text("Partecipanti"),
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
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
            ),

            InkWell(
              child: GestureDetector(
                onTap: () {print("Il listener funziona!");},
                child: Container(
                  child: Text(
                    'Iscriviti!',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white, fontSize: 20),
                  ),
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

