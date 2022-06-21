import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';

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
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Logout'),
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[50],
                    ),
                    child: Text(
                      'Pet House',
                      style: TextStyle(
                        backgroundColor: Colors.pink[50],
                        color: Colors.pink[400],
                        fontSize: 50.0,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
