import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/pages/authenticate/login.dart';
import 'package:purrfect_compawnion/pages/features/home.dart';
import 'package:purrfect_compawnion/pages/features/pethouse.dart';


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
