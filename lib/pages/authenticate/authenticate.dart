import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/pages/authenticate/login.dart';
import 'package:purrfect_compawnion/pages/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? Login(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
