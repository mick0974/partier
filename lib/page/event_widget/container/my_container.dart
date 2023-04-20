import 'dart:ffi';

import 'package:fancy_containers/src/utils/fancy_containers_typedef.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {

  const MyContainer({
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
    this.space_for_button,
    this.image_path,
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
  final String? space_for_button;
  final String? image_path;

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {


  @override
  Widget build(BuildContext context) {
    // spazio da lasciare nella stringa
    String text_space = widget.space_for_button ?? '                       ';
    return Container(
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
                            widget.title + text_space,
                            style: widget.titleStyle ??
                                TextStyle(
                                  color: widget.textColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
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
