import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';
import 'package:purrfect_compawnion/shared/loading.dart';

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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red[50],
            body: SingleChildScrollView(
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          // Form to fill in email
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
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
                            height: 50.0,
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
                                      MaterialStateProperty.all(Colors.pink[400]),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      setState(() => loading = true);
                                      await _auth.signInWithEmailAndPassword(email, password);
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        error = e.message!;
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                                'Forgot Password?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue[600],
                                fontSize: 14.0,

                              ),
                            ),
                            onTap: () => Navigator.pushNamed(context, '/resetPassword'),
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
