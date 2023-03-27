import 'package:flutter/material.dart';

/// Animated widget for bottom bar.
/// This widget defines a widget having an icon and a label which, when
/// pressed, resizes. In particular, it can be either a discover's widget or a
/// user's wodget.
class BarWidget extends StatefulWidget {
	bool _selected = 0;
	String _type;

	// Getters & setters
	bool get selected => _selected;
	bool set selected(bool b) => _selected = b;
	String set type(String s) => _type = s;

	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

/// Defines BarWidget's layout and behaviour.
/// The widget will be a ... and, when pressed, resizes as follows:
/// * If widget is selected then it's resized so that only the icon is visible;
/// * Otherwise resizes to display both the icon and the label.
/// Can be of two types:
/// * Type 'D' corresponds to the discover's widget;
/// * Type 'U' corresponds to the user's wodget.
class _BarWidgetState extends State<BarWidget> {
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () {
				setState(() {
					selected = !selected;
				});
			},
			child: Center(
				child: AnimatedContainer(
					width: selected ? 200.0 : 100.0,
					height: selected ? 100.0 : 200.0,
					color: selected ? Colors.red : Colors.blue,
					alignment:
						selected ? Alignment.center : AlignmentDirectional.topCenter,
					duration: const Duration(seconds: 2),
					curve: Curves.fastOutSlowIn,
					child: const FlutterLogo(size: 75),
				),
			),
		);
	}
}