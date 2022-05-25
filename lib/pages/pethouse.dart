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
      body: Text('PetHouse'),
    );
  }
}
