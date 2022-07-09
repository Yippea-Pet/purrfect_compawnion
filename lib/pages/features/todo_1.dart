import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:purrfect_compawnion/pages/features/add_task_bar.dart';
import 'package:purrfect_compawnion/pages/ui/widgets/button.dart';
import 'package:purrfect_compawnion/services/notification_services.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:purrfect_compawnion/shared/loading.dart';
import 'package:purrfect_compawnion/pages/features/task_list.dart';

class ToDo extends StatefulWidget {
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DateTime _selectedDate = DateTime.now();
  // final _taskController = Get.put(TaskController());
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
                  _buildTaskList(),
                ],
              ),
            );
          }

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
          setState(() => _selectedDate = date);
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
            // _taskController.getTasks();
          },
        ),
      ]),
    );
  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.red[200],
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
    return TaskList(selectedDate: _selectedDate,);
  }

}
