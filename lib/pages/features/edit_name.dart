import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/services/database.dart';
import 'package:purrfect_compawnion/shared/constants.dart';

import '../../models/myuser.dart';

class editName extends StatefulWidget {
  const editName({Key? key}) : super(key: key);

  @override
  State<editName> createState() => _editNameState();
}

class _editNameState extends State<editName> {
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  String name = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    var db = FirebaseFirestore.instance;

    var petName =
        db.collection("users").doc(user.uid).collection("pet").doc("name");
    petName.get().then((DocumentSnapshot doc) async {
      dynamic data = doc.data() as Map<String, dynamic>;
      name = data['name'];
    });

    return AlertDialog(
      title: Text("You wanna rename me?"),
      content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("What would you like to call me? \n (｡･ω･｡)"),
              TextFormField(
                initialValue: name,
                decoration: textInputDecoration,
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a name!' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseService(uid: user.uid)
                        .updatePetName(_currentName ?? name);
                    Navigator.pop(context);
                  }
                },
                child: Text("OK"),
              ),
            ],
          )),
    );
  }
}
