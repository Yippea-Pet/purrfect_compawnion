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
  bool obscurePassword = true;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.orange[200],
      //   elevation: 0.0,
      //     title: Text('Sign In'),
      //   actions: <Widget>[
      //     TextButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text('Register'),
      //       onPressed: () {
      //         widget.toggleView();
      //       },
      //     ),
      //   ],
      // ),
      body:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Image.asset('assets/Logo.png'),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      // Form to fill in email
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? "Enter an email" : null,
                          onChanged: (value) {
                            setState(() => (email = value));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Form to fill in password
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(Icons.visibility)),
                            // suffixIcon: Icon(Icons.visibility),
                          ),
                          obscureText: obscurePassword,
                          validator: (val) => val!.length < 6
                              ? "Enter a password with at least 6 characters"
                              : null,
                          onChanged: (value) {
                            setState(() => (password = value));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Sign in button
                      SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                            // onPressed function needs to be async because it will
                            // interact with firebase
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
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
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          TextButton(
                              onPressed: widget.toggleView,
                              child: Text("Sign Up!")),
                        ],
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
