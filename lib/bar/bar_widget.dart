import 'package:flutter/material.dart';

/// Animated widget for bottom bar.
/// This defines a widget having an icon and a label which, when pressed,
/// resizes. In particular, it can reidirect to either a discover's widget or a
/// user's widget.
class BarWidget extends StatefulWidget {
	final String _type;
	bool _selected;

	// Getter & setter
	String get type => _type;
	bool get selected => _selected;
	set selected(bool b) => _selected = b;

	const BarWidget({this._type});

	@override
	State<BarWidget> createState() => _BarWidgetState();
}

/// Defines BarWidget's layout and behaviour.
class _BarWidgetState extends State<BarWidget> {

	@override
	Widget build(BuildContext context) {
		/*
	    return GestureDetector(
	      onTap: () {
	        setState(() {
	          selected = !selected;
	        });
	      },
	      child: Center(
	        child: Container(
	          width: 250.0,
	          height: 250.0,
	          color: Colors.red,
	          child: AnimatedAlign(
	            alignment: selected ? Alignment.topRight : Alignment.bottomLeft,
	            duration: const Duration(seconds: 1),
	            curve: Curves.fastOutSlowIn,
	            child: const FlutterLogo(size: 50.0),
	          ),
	        ),
	      ),
	    );
		*/
	}
}