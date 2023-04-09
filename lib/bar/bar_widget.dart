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
/// STILL HAS TO BE ANIMATED -> AnimatedAlign? AnimatedContainer?
class _BarWidgetState extends State<BarWidget> {

	@override
	Widget build(BuildContext context) {
		return FilledButton.icon(
			onPressed: () {ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Switch to explore mode.'),
					duration: Duration(milliseconds: 1000)));
					setState(() {
						explore = true;
						create = false;
					});
				},
			label: const Text('Explore'),
			icon: const Icon(Icons.map_outlined),
			style: explore
					? ElevatedButton.styleFrom(
						// minimumSize: const Size.fromHeight(1),
						padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
			)
					: ElevatedButton.styleFrom(
						primary: Colors.black26,
						padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
					),
		);
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