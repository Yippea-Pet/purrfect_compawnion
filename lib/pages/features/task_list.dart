import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/models/myuser.dart';
import 'package:purrfect_compawnion/models/task.dart';
import 'package:purrfect_compawnion/pages/features/todo_1.dart';
import 'package:purrfect_compawnion/shared/loading.dart';

import '../ui/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    final taskList = Provider.of<List<Task>?>(context) ?? [];

    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskTile(
            task: taskList[index]
        );
      },
    );

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.pink[100],
              ),
              title: _showTitle(user),
              subtitle: _showNote(user),
            )));
  }

  _showTitle(user) {
    return user != null
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection("tasks")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Loading();
              else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        return ListTile(
                          title: Text(doc["title"]),
                        );
                      }),
                );
              }
            },
          )
        : null;
  }

  _showNote(user) {
    return user != null
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection("tasks")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Loading();
              else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        return ListTile(
                          title: Text(doc["note"]),
                        );
                      }),
                );
              }
            },
          )
        : null;
  }
}
