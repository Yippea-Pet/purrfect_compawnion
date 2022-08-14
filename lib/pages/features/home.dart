import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';
import 'package:purrfect_compawnion/shared/constants.dart';

import '../../services/notification_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.asset('assets/Logo.png')
            ),
            Expanded(
              flex: 3,
              child: Image.asset('assets/MovingSoccat.GIF'),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/pethouse');
                            },
                            style: homeButtonStyle,
                            child: Text(
                              'Pet House',
                              style: TextStyle(
                                // backgroundColor: Colors.pink[100],
                                color: Colors.pink[400],
                                fontSize: MediaQuery.of(context).size.width * 0.1,
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/todo');
                            },
                            style: homeButtonStyle,
                            child: Text(
                              'Tasks',
                              style: TextStyle(
                                // backgroundColor: Colors.pink[100],
                                color: Colors.pink[400],
                                fontSize: MediaQuery.of(context).size.width * 0.1,
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/weather');
                            },
                            style: homeButtonStyle,
                            child: Text(
                              'Weather',
                              style: TextStyle(
                                // backgroundColor: Colors.pink[100],
                                color: Colors.pink[400],
                                fontSize: MediaQuery.of(context).size.width * 0.1,
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
