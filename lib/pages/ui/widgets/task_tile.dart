import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purrfect_compawnion/models/task.dart';
import 'package:purrfect_compawnion/shared/constants.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: task!.color == 0
              ? taskColor1
              : task!.color == 1
                  ? taskColor2
                  : taskColor3,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: taskTitleStyle,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "${task!.date}",
                  style: taskTimeStyle.copyWith(letterSpacing: 2.0),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: taskTileFontColor,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: taskTimeStyle,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  task?.note ?? "",
                  style: taskNoteStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: taskTileFontColor.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: taskTileFontColor),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
