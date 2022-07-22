import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/loadingbg.png"),
        fit: BoxFit.cover,
        ),
        ),
        child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Image.asset('assets/sleepingsoccat.GIF')
          ),
        ]
        )
      )
    );
  }
}
