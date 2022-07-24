import 'package:flutter/material.dart';

class userGuide extends StatefulWidget {
  const userGuide({Key? key}) : super(key: key);

  @override
  State<userGuide> createState() => _userGuideState();
}

class _userGuideState extends State<userGuide> {
  int pages = 1; // pages of current user guide
  List<String> instructions = [
    "Bond with your pet by earning friendship exp! The Friendship Level goes up if you feed or play with soccat. Hunger Level goes down overtime so remember to feed soccat regularly. You can change your pet's name by clicking on the pen icon",
    "You can obtain fish to feed soccat with by accomplishing tasks on time. 10 fish are given to you by default in the beginning. Tasks can be done in the 'Tasks' feature. Feed soccat by pressing on the left round icon!",
    "You can play with soccat to increase your friendship level. Play with soccat by pressing on the right round icon!",
  ];
  List imgList = [
    Image.asset("assets/1.jpg"),
    Image.asset("assets/2.jpg"),
    Image.asset("assets/3.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${pages} of ${instructions.length}"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Image.asset("assets/SoccatSleep.PNG"),
          imgList[pages - 1],
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
