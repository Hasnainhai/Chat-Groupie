import 'package:flutter/material.dart';

const textInputDecoretion = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 2,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.orangeAccent,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
);

void nextPage(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void previousPage(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (contex) => page));
}
