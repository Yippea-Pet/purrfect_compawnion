import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/pages/authenticate/login.dart';
import 'package:purrfect_compawnion/pages/features/home.dart';
import 'package:purrfect_compawnion/pages/features/pethouse.dart';
import 'package:purrfect_compawnion/pages/features/welcome.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/welcome',

    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/pethouse': (context) => PetHouse(),
      '/welcome' : (context) => Welcome(),
    },
  ));
}
