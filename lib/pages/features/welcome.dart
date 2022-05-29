import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text(
          'Get started'
        ),

      )
    );
  }
}
