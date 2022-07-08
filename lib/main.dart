import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/db/db_helper.dart';
import 'package:purrfect_compawnion/pages/authenticate/login.dart';
import 'package:purrfect_compawnion/pages/authenticate/register.dart';
import 'package:purrfect_compawnion/pages/features/home.dart';
import 'package:purrfect_compawnion/pages/features/pethouse.dart';
import 'package:purrfect_compawnion/pages/features/welcome.dart';
import 'package:purrfect_compawnion/pages/features/todo_1.dart';
import 'package:purrfect_compawnion/pages/wrapper.dart';
import 'package:purrfect_compawnion/services/auth.dart';

import 'models/myuser.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: GetMaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/welcome': (context) => Welcome(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/home': (context) => Home(),
          '/pethouse': (context) => PetHouse(),
          '/todo': (context) => ToDo(),
          '/tasktile': (context) => TaskTile(),
          '/weather': (context) => Weather()
        },
      ),
    );
  }
}