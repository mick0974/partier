import 'package:flutter/material.dart';


class MyPoll extends StatefulWidget {
  const MyPoll({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  _MyPollState createState() => _MyPollState();


}

class _MyPollState extends State<MyPoll>{
  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          widget.onChanged(!widget.value);
        },
        child: Padding(
          padding: widget.padding,
          child: Row(
            children: <Widget>[
              Expanded(child: Text(widget.label)),
              Checkbox(
                value: widget.value,
                onChanged: (bool? newValue) {
                  widget.onChanged(newValue!);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

