import 'package:flutter/material.dart';

import 'package:fancy_containers/src/utils/fancy_containers_typedef.dart';
import 'my_pop_up_event.dart';

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
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  Widget _buildEventDialog(BuildContext context) {
    return MyPopupEvent(
      title: widget.title,
      image_path: widget.image_path ?? 'assets/images/sanremo.jpg',
      subtitle: widget.subtitle ?? '',
      date: widget.date,
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
          //width: MediaQuery.of(context).size.width*0.9,
          //height: MediaQuery.of(context).size.height*0.17,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // alignment: Alignment.center,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height*0.09,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20)
                    ),
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
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20)
                    ),
                  ),
                  child: //Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        ],
                      ),
                    //],
                    // backgroundColor: Colors.white,
                    // title: Text(widget.title),
                    // titleTextStyle: TextStyle(color: Colors.black),
                  ),
                ),
              //)
            ],
          ),
        )
      );
  }
}
