import 'package:flutter/material.dart';

class userGuide extends StatefulWidget {
  const userGuide({Key? key}) : super(key: key);

  @override
  State<userGuide> createState() => _userGuideState();
}

class _userGuideState extends State<userGuide> {
  int pages = 1; // pages of current user guide
  List<String> instructions = [
    "This is page 1",
    "This is page 2",
    "This is page 3",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${pages} of ${instructions.length}"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset("assets/SoccatSleep.PNG"),
          Text(instructions[pages - 1]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              pages == 1
                  ? SizedBox()
                  : TextButton(
                      onPressed: () => setState(() => pages -= 1),
                      child: Text("BACK"),
                    ),
              pages == instructions.length
                  ? TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    )
                  : TextButton(
                      onPressed: () => setState(() => pages += 1),
                      child: Text("NEXT"),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
