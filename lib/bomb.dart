import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  final reveal;
  final function;
  Bomb({required this.reveal, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Container(
          color: reveal ? Colors.grey[800] : Colors.grey[400],
        ),
      ),
    );
  }
}
