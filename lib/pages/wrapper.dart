import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/myuser.dart';
import 'authenticate/authenticate.dart';
import 'features/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    // Check if the user login successfully
    // return Home if success, Authenticate otherwise
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
