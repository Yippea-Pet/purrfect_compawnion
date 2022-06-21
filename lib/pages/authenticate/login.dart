import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';

import '../../shared/constants.dart';

class Login extends StatefulWidget {
  final toggleView;

  const Login({Key? key, this.toggleView}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        elevation: 0.0,
          title: Text('Sign In'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/Logo.png'),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Form to fill in email
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? "Enter an email" : null,
                      onChanged: (value) {
                        setState(() => (email = value));
                      },
                    ),
                    SizedBox(height: 5.0,),
                    // Form to fill in password
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? "Enter a password with at least 6 characters" : null,
                      onChanged: (value) {
                        setState(() => (password = value));
                      },
                    ),
                    SizedBox(height: 10.0,),
                    // Sign in button
                    ElevatedButton(
                      // onPressed function needs to be async because it will
                      // interact with firebase
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.pink),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Error signing in!';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
