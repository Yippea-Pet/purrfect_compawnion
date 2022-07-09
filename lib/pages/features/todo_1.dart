import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purrfect_compawnion/models/task.dart';
import 'package:purrfect_compawnion/controllers/task_controller.dart';
import 'package:purrfect_compawnion/pages/features/add_task_bar.dart';
import 'package:purrfect_compawnion/pages/ui/widgets/button.dart';
// import 'package:purrfect_compawnion/pages/ui/widgets/task_list.dart';
import 'package:purrfect_compawnion/services/database.dart';
import 'package:purrfect_compawnion/services/notification_services.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:purrfect_compawnion/shared/loading.dart';
import 'package:purrfect_compawnion/pages/features/task_list.dart';

import '../../models/myuser.dart';

class ToDo extends StatefulWidget {
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return loading
            ? Loading()
            : Scaffold(
              appBar: _appBar(),
              body: Column(
                children: [
                  _addTaskBar(),
                  _addDateBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: _buildTaskList(),
                  )
                ],
              ),
            );
          }

  // _showTasks(user) {
  //   // final user = Provider.of<MyUser>(context);
  //
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection("tasks").snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return Loading();
  //       else {
  //         return Expanded(
  //             child: _buildTaskList(snapshot.data!),
  //         );
  //       }
  //     },
  //   );
  //   // final tasks = DatabaseService(uid: user.uid).collection("users");
  //   // return Column(
  //   //   children: [
  //   //     StreamBuilder(
  //   //         builder: (BuildContext context, AsyncSnapshot))
  //   //   ],
  //   // );
  //   // return Expanded(
  //   //   child: Obx(() {
  //   //     return ListView.builder(
  //   //         itemCount: _taskController.taskList.length,
  //   //         itemBuilder: (_, index) {
  //   //           print(_taskController.taskList.length);
  //   //           /*AnimationConfiguration.staggeredList(
  //   //           position: index,
  //   //           child: SlideAnimation(
  //   //               child: FadeInAnimation(
  //   //                 child: Row(
  //   //                   children: [
  //   //                     GestureDetector(
  //   //                       onTap: () {
  //   //                         _showBottomSheet(context, _taskController.taskList[index]);
  //   //                       },
  //   //                       child: TaskTile(_taskController.taskList[index])
  //   //                     )
  //   //                   ],
  //   //                 )
  //   //               )
  //   //           )
  //   //         );
  //   //         GestureDetector(
  //   //         onTap: () {
  //   //           _taskController.delete(_taskController.taskList[index]);
  //   //         },
  //   //         child: Container(
  //   //           width: 100,
  //   //           height: 50,
  //   //           color: Colors.green,
  //   //           margin: const EdgeInsets.only(bottom: 10),
  //   //           child: Text(
  //   //             _taskController.taskList[index].title.toString()
  //   //           ),
  //   //         ),
  //   //       );*/
  //   //         });
  //   //   }),
  //   // );
  // }

  /*_showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:4),
        height: task.isCompleted==1?
            MediaQuery.of(context).size.height*0.24:
            MediaQuery.of(context).size.height*0.32

      )
    );
  }*/

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.pinkAccent,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Text(
                "Today",
                style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        MyButton(
          label: "+ Add Task",
          onTap: () async {
            await Get.to(() => AddTaskPage());
            _taskController.getTasks();
          },
        ),
      ]),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.red[200],
      // leading: GestureDetector(
      //   onTap: () {
      //     notifyHelper.scheduledNotification();
      //   },
      //   child: InkWell(
      //     onTap: () {
      //       print("clicked the back button");
      //       Navigator.pop(this.context);
      //     },
      //     child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
      //   ),
      // ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/emptyprofile.png"),
            ),
          ),
        )
      ],
    );
  }

  _buildTaskList() {
    // return TaskList();
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Task>?>.value(
      initialData: null,
      value: DatabaseService().tasks,
      child: TaskList(),
    );
    // return ListView.builder(
    //   itemCount: snapshot.docs.length,
    //   itemBuilder: (context, index) {
    //     final doc = snapshot.docs[index];
    //     return TaskList();
    //      return Dismissible(
    //          key: Key(doc.id),
    //          background: Container(color: Colors.red),
    //          onDismissed: (direction) {
    //            DatabaseService(uid: user.uid).deleteTask(doc.id);
    //          },
    //          child: ListTile(
    //            title: Text(doc["title"]),
    //          )
    //      );
    //     return ListTile(
    //       title: Text(doc["title"]),
    //     );
    //   });
  }

}
