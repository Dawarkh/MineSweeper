import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final child;
  final reveal;
  final function;
  NumberBox({this.child, required this.reveal, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Container(
          color: reveal ? Colors.grey[300] : Colors.grey[400],
          child: Center(
              child: Text(
            reveal ? (child == 0 ? " " : child.toString()) : " ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: child == 1
                  ? Colors.blue
                  : (child == 2 ? Colors.green : Colors.red),
            ),
          )),
        ),
      ),
    );
  }
}
