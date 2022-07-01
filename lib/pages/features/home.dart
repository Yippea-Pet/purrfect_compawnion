import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';
import 'package:purrfect_compawnion/services/get_weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

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
              flex: 4,
              child: Image.asset('assets/MovingSoccat.GIF'),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pethouse');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      backgroundColor: MaterialStateProperty.all(Colors.pink[100]),
                    ),
                    child: Text(
                      'Pet House',
                      style: TextStyle(
                        // backgroundColor: Colors.pink[100],
                        color: Colors.pink[400],
                        fontSize: 40.0,
                      ),
                    )
                ),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () async {
            //       Weather weather = new Weather(location: 'Singapore', url: '??');
            //       await weather.getWeather();
            //     },
            //     child: Text("TEST")
            // ),
          ],
        ),
      ),
    );
  }
}
