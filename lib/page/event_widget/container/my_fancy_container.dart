import 'package:fancy_containers/src/utils/fancy_containers_typedef.dart';
import 'package:flutter/material.dart';

class MyFancyContainer extends StatefulWidget {

  const MyFancyContainer({
    Key? key,
    this.height,
    this.width,
    this.color1,
    this.color2,
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                   widget.title + '       ',
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
                               IconButton(onPressed: () {}, icon: Icon(Icons.add),
                                   // iconSize: 5,
                                   )
                             ],
                           ),

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
