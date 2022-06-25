import 'package:flutter/material.dart';

// const textBoxColor = Color(Colors.teal[50]);
const textInputDecoration = InputDecoration(
    fillColor: Color(0xFFE0F2F1),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),

    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    )

);
