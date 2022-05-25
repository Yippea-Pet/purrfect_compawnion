import 'dart:ffi';

import 'package:flutter/material.dart';

class PetHouse extends StatefulWidget {
  const PetHouse({Key? key}) : super(key: key);

  @override
  State<PetHouse> createState() => _PetHouseState();
}

class _PetHouseState extends State<PetHouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Soccat!'),
          backgroundColor: Colors.red[200],
        ),

        body: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Image.asset('assets/MovingSoccat.GIF'),
            ),
            Expanded(
              flex: 1,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Friendship Level: 0'),
                ),
              ),
            ),

          ],
        ),

        floatingActionButton: FloatingActionButton(
        onPressed: ()
    {},
    child: Icon(Icons.coffee),
    )
    ,
    );
  }
}
