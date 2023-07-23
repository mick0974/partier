import 'package:flutter/material.dart';

import 'package:fancy_containers/src/utils/fancy_containers_typedef.dart';
import '../myPoll.dart';
import '../../../services/api.dart';


class MyFancyContainer extends StatefulWidget {

  const MyFancyContainer({
    Key? key,
    this.height,
    this.width,
    this.color1,
    this.color2,
    required this.id,
    required this.title,
    this.textColor,
    this.subtitle,
    this.subtitleColor,
    this.onTap,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.image_path,
    required this.date,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color1;
  final Color? color2;
  final String id;
  final String title;
  final Color? textColor;
  final String? subtitle;
  final Color? subtitleColor;
  final FancyContainersCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String? image_path;
  final String date;

  @override
  _MyFancyContainerState createState() => _MyFancyContainerState();
}

class _MyFancyContainerState extends State<MyFancyContainer> {

  bool option_1 = false;
  bool option_2 = false;
  bool option_3 = false;
  bool option_4 = false;
  int counter = 0;

  Widget _buildEventDialog(BuildContext context) {

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


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildEventDialog(context),
        );
      },
    child: Container(
        alignment: Alignment.center,
        width: widget.width ?? MediaQuery.of(context).size.width*0.95,
        height: widget.height ?? MediaQuery.of(context).size.height*0.2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(colors: [
            widget.color1 ?? Colors.lightGreenAccent,
            widget.color2 ?? Colors.lightBlue
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.17,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            ),
            ],
          ),
          child: Column(
           children: [
             Expanded(child: Container(
                 // alignment: Alignment.center,
                 // width: MediaQuery.of(context).size.width,
                 // height: MediaQuery.of(context).size.height*0.09,
                 decoration: BoxDecoration(
                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0),
                   topRight: Radius.circular(20)),
                   image: DecorationImage(
                     image: AssetImage(widget.image_path ?? 'assets/images/sanremo.jpg'),
                     opacity: 0.5,
                     fit: BoxFit.fitWidth,
                   ),
                 ),
               ),
             ),
             Expanded(
               child: Container(
               // alignment: Alignment.center,
               // width: MediaQuery.of(context).size.width,
               // height: MediaQuery.of(context).size.height*0.09,
               decoration: BoxDecoration(
                 color: Colors.white24,
                 borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0),
                     bottomRight: Radius.circular(20)),
               ),
               child: Column(
                         // mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: Text(
                                   widget.title,
                                   style: widget.titleStyle ??
                                       TextStyle(
                                         color: widget.textColor,
                                         fontSize: 20.0,
                                         fontWeight: FontWeight.bold,
                                       ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: Text(
                                   widget.date,
                                   style: widget.titleStyle ??
                                       TextStyle(
                                         color: widget.textColor,
                                         fontSize: 15.0,
                                       ),
                                 ),
                               ),
                               Expanded(
                                 child: IconButton(
                                   onPressed: () {
                                     String eventId = widget.id;
                                     Api().addUser(eventId);
                                   },
                                   icon: const Icon(Icons.add),
                                   // iconSize: 5,
                                 ),
                               )
                             ],
                           ),

                           /*
                           widget.subtitle != null
                               ? Padding(
                                   padding: const EdgeInsets.all(2.0),
                                   child: Text(
                                    widget.subtitle ?? "",
                                    style: widget.subtitleStyle ??
                                     TextStyle(
                                       color: widget.subtitleColor,
                                       fontSize: 15.0,
                                     ),
                                  ),
                                 )
                               : Container(),
                            */

                         ],
                       // backgroundColor: Colors.white,
                       // title: Text(widget.title),
                       // titleTextStyle: TextStyle(color: Colors.black),
               ),
                ),

               )
               ],
             ),
             ),
          )
    );

        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child: Text(
        //         widget.title,
        //         style: widget.titleStyle ??
        //             TextStyle(
        //               color: widget.textColor,
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //       ),
        //     ),
        //     widget.subtitle != null
        //         ? Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child: Text(
        //         widget.subtitle ?? "",
        //         style: widget.subtitleStyle ??
        //             TextStyle(
        //               color: widget.subtitleColor,
        //               fontSize: 15.0,
        //             ),
        //       ),
        //     )
        //         : Container(),
        //   ],
        // ),


  }
}
