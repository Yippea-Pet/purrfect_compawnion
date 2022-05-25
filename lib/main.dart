import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/pages/home.dart';
import 'package:purrfect_compawnion/pages/login.dart';
import 'package:purrfect_compawnion/pages/pethouse.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/pethouse',

    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/pethouse': (context) => PetHouse(),
    },
  ));
}
