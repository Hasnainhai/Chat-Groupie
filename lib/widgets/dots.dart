import 'package:flutter/material.dart';

class dots extends StatelessWidget {
  Color color;
  dots({required this.color});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        color: color,
      ),
    );
  }
}
